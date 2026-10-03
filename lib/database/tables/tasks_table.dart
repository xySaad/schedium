import 'package:drift/drift.dart';
import 'package:schedium/model/model.dart' as model;

class Tasks extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get state => textEnum<model.TaskState>()();
  BoolColumn get isDeleted => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
