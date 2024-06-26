import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/sl.dart';
import '../../data/models/host.dart';
import '../../data/repositories/stats.dart';
import '../../data/service/monitoring.dart';
import '../drawer/app_drawer.dart';
import 'components/host_tile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void minimize() => const MethodChannel('main').invokeMethod('minimize');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        minimize();
        return false;
      },
      child: const Scaffold(endDrawer: AppDrawer(), body: HostsList()),
    );
  }
}

class HostsList extends StatefulWidget {
  const HostsList({super.key});

  @override
  State<HostsList> createState() => _HostsListState();
}

class _HostsListState extends State<HostsList> {
  final StatsRepository statsRepository = SL.statsRepository;
  final MonitoringService monitoringService = SL.monitoringService;

  List<Host> hosts = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    hosts = await statsRepository.getAllHosts();
    statsRepository.eventBus
        .where((event) => event is HostsUpdated)
        .cast<HostsUpdated>()
        .forEach((event) {
      setState(() => hosts = event.hosts);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar(
              title: Text('Monitoring hosts'),
              floating: true,
              pinned: false,
              snap: true),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: _PinnedSliverDelegate(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 12),
                  Tooltip(
                    message: 'Current host activity',
                    child: Text('Act', style: TextStyle(fontSize: 14)),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Tooltip(
                      message: 'Host adress',
                      child: Text('Host', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Tooltip(
                    message: 'Summary stats of recent activity',
                    child: Text('Stats', style: TextStyle(fontSize: 14)),
                  ),
                  SizedBox(width: 32),
                  Tooltip(
                    message: 'Preview of recent activity',
                    child: Text('Preview', style: TextStyle(fontSize: 14)),
                  ),
                  SizedBox(width: 32),
                  Text('More', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 16),
                ],
              ),
            ),
          ),
          for (var host in hosts) HostTile(host: host, key: Key(host.adress)),
          if (hosts.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.data_array),
                    SizedBox(height: 16),
                    Text('No hosts added yet'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PinnedSliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _PinnedSliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final backColor = Theme.of(context).colorScheme.background;
    return SizedBox.expand(child: Container(color: backColor, child: child));
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant _PinnedSliverDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
