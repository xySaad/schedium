import 'package:drift/drift.dart';
import 'package:schedium/schedium/drift_converters.dart';
import 'package:schedium/model/model.dart';

class Tasks extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text().map(SignalConverter.plain())();
  TextColumn get description =>
      text().nullable().map(SignalConverter.nullable())();
  TextColumn get state =>
      text().map(SignalConverter.forEnum(TaskState.values))();
  BoolColumn get isDeleted => boolean().map(SignalConverter.plain())();

  @override
  Set<Column> get primaryKey => {id};
}
