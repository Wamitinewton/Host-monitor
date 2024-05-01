
import 'package:cipherly/host%20manager/data/drift/db.dart';
import 'package:cipherly/host%20manager/data/repositories/settings.dart';
import 'package:cipherly/host%20manager/data/repositories/stats.dart';
import 'package:cipherly/host%20manager/data/service/monitoring.dart';

abstract class SL {
  static final _drift = DB();

  static final SettingsRepository settingsRepository = SettingsRepositoryPrefsImpl();
  static final StatsRepository statsRepository = StatsRepositoryDriftImpl(_drift.statsDao);

  static final MonitoringService monitoringService = MonitoringService(statsRepository, settingsRepository);
}
