import 'dart:io';
import 'package:cipherly/host%20manager/core/app_logger.dart';
import 'package:cipherly/host%20manager/data/drift/tables/stats.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

@DriftDatabase(tables: [HostsTable, PingTable], daos: [StatsDao])
class DB extends _$DB {
  DB({QueryExecutor? e}) : super(e ?? _executor);

  /// Default connection executor
  static get _executor => LazyDatabase(() async {
        final dbDir = await getApplicationDocumentsDirectory();
        final fullPath = path.join(dbDir.path, 'db.sqlite');
        return NativeDatabase.createInBackground(File(fullPath));
      });

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        AppLogger.debug('drift onCreate');
        await migrator.createAll();

        // Filling default hosts across the world

        // USA
        migrator.database.customInsert(
          'INSERT INTO hosts_table (adress, enabled) VALUES (?, ?)',
          variables: [Variable.withString('8.8.8.8'), Variable.withBool(true)],
        );

        // // China
        // migrator.database.customInsert(
        //   'INSERT INTO hosts_table (adress, enabled) VALUES (?, ?)',
        //   variables: [Variable.withString('223.6.6.6'), Variable.withBool(true)],
        // );

        // // Australia
        // migrator.database.customInsert(
        //   'INSERT INTO hosts_table (adress, enabled) VALUES (?, ?)',
        //   variables: [Variable.withString('103.86.96.100'), Variable.withBool(true)],
        // );

        // // Uganda
        // migrator.database.customInsert(
        //   'INSERT INTO hosts_table (adress, enabled) VALUES (?, ?)',
        //   variables: [Variable.withString('154.72.202.86'), Variable.withBool(true)],
        // );
      },
      onUpgrade: (migrator, from, to) async {
        AppLogger.debug('drift onUpgrade: $from -> $to');
        // if (from < 3) {
        //   // blah blah
        // }
      },
      beforeOpen: (openingDetails) async {
        AppLogger.debug('drift beforeOpen ${openingDetails.versionNow}');

        if (openingDetails.hadUpgrade) {
          final m = createMigrator();
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
            await m.createTable(table);
          }
        }
      },
    );
  }
}
