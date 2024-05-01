
import 'package:cipherly/host%20manager/data/drift/db.dart';
import 'package:cipherly/host%20manager/data/models/host.dart';
import 'package:cipherly/host%20manager/data/models/ping.dart';

DriftHost _fromHost(Host host) {
  return DriftHost(adress: host.adress, enabled: host.enabled);
}

Host _toHost(DriftHost driftHost) {
  return Host(adress: driftHost.adress, enabled: driftHost.enabled);
}

DriftPing _fromPing(Ping ping) {
  return DriftPing(host: ping.host, timestamp: ping.time.millisecondsSinceEpoch, latency: ping.latency, lost: ping.lost);
}

Ping _toPing(DriftPing driftPing) {
  return Ping(host: driftPing.host, time: DateTime.fromMillisecondsSinceEpoch(driftPing.timestamp), latency: driftPing.latency, lost: driftPing.lost);
}

abstract class StatsMapper {
  static DriftHost fromHost(Host host) => _fromHost(host);
  static Host toHost(DriftHost host) => _toHost(host);

  static DriftPing fromPing(Ping ping) => _fromPing(ping);
  static Ping toPing(DriftPing ping) => _toPing(ping);
}
