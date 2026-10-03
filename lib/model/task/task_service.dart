import 'package:schedium/database/database.dart' as database;
import 'package:schedium/model/model.dart' as model;

class TaskService {
  TaskService(this.db);

  final database.$AppDatabase db;

  Future<List<model.Task>> loadAll() async {
    final rows = await db.select(db.tasks).get();
    final tasks = rows.map(rowToTask).toList();
    return tasks;
  }

  Future<int> update(int id, database.TasksCompanion companion) {
    final stmt = db.update(db.tasks)..where((t) => t.id.equals(id));
    return stmt.write(companion);
  }

  model.Task rowToTask(database.Task row) => model.Task(
    row.id,
    row.title,
    description: row.description,
    state: row.state,
  );
}
