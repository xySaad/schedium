import 'package:drift/drift.dart';
import 'package:schedium/database/database.dart';
import 'package:schedium/model/model.dart';
import 'package:schedium/schedium/drift_converters.dart';
import 'package:schedium/schedium/persistent_item.dart';

class TaskModel extends Task with PersistentRow<$TasksTable, Task> {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.state,
    required super.isDeleted,
  });

  TaskModel.create(
    int id,
    String title, {
    String? description,
    TaskState state = TaskState.undone,
    bool isDeleted = false,
  }) : super(
         id: id,
         title: DriftSignal(title),
         description: DriftSignal(description),
         isDeleted: DriftSignal(isDeleted),
         state: DriftSignal(state),
       );

  @override
  Expression<bool> filter($TasksTable t) => t.id.equals(id);

  @override
  List<(DriftSignal, TasksCompanion)> get columns => [
    (title, TasksCompanion(title: Value(title))),
    (description, TasksCompanion(description: Value(description))),
    (state, TasksCompanion(state: Value(state))),
    (isDeleted, TasksCompanion(isDeleted: Value(isDeleted))),
  ];
}
