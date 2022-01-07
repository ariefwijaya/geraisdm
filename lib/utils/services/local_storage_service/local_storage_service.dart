import 'package:drift/drift.dart';

import 'tables/sessions_table.dart';

export 'database/shared.dart';

part 'local_storage_service.g.dart';

@DriftDatabase(tables: [Sessions])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: (openingDetails) async {
        // if (Env.showLog) {
        //   //if debug mode
        //   final m = Migrator(this);
        //   for (final table in allTables) {
        //     await m.deleteTable(table.actualTableName);
        //     await m.createTable(table);
        //   }
        // }
      });
}
