import 'package:drift/drift.dart';

abstract class PersistentItem<Tbl extends Table, R> {
  void syncToDB(GeneratedDatabase db, TableInfo<Tbl, R> table);
  R toCompanion();
}
