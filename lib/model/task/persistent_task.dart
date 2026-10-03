import 'package:drift/drift.dart';
import 'package:schedium/model/model.dart';
import 'package:schedium/database/database.dart' as database;
import 'package:schedium/schedium/persistent_item.dart';

typedef TaskTableInfo = TableInfo<database.$TasksTable, database.Task>;
typedef PersistentItemTask =
    PersistentItem<database.$TasksTable, database.Task>;

class PersistentTask extends Task implements PersistentItemTask {
  PersistentTask.fromRow(database.Task task)
    : super(
        task.id,
        task.title,
        description: task.description,
        state: task.state,
        isDeleted: task.isDeleted,
      );

  PersistentTask(
    super.id,
    super.title, {
    super.description,
    super.isDeleted,
    super.state,
  });

  @override
  database.Task toCompanion() => database.Task(
    id: id,
    title: title.peek(),
    description: description.peek(),
    state: state.value,
    isDeleted: false,
  );

  @override
  void syncToDB(GeneratedDatabase db, TaskTableInfo table) {
    title.subscribe(
      (v) => _update(db, table, database.TasksCompanion(title: Value(v))),
    );
    state.subscribe(
      (v) => _update(db, table, database.TasksCompanion(state: Value(v))),
    );
    description.subscribe(
      (v) => _update(db, table, database.TasksCompanion(description: Value(v))),
    );
    isDeleted.subscribe(
      (v) => _update(db, table, database.TasksCompanion(isDeleted: Value(v))),
    );
  }

  Future<int> _update(
    GeneratedDatabase db,
    TaskTableInfo table,
    database.TasksCompanion comnaion,
  ) {
    final stmt = db.update(table)..where((t) => t.id.equals(id));
    return stmt.write(toCompanion());
  }
}
