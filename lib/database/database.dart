import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/tables.dart';
import 'database.drift.dart';

export 'tables/tables.dart';
export 'database.drift.dart';

@DriftDatabase(tables: [Tasks])
class AppDatabase extends $AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'schedium'));

  @override
  int get schemaVersion => 1;
}
