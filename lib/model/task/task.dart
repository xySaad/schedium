export 'task_state.dart';
export 'persistent_task.dart';

import 'package:schedium/model/task/task_state.dart';
import 'package:signals_flutter/signals_core.dart';

class Task {
  Task(
    this.id,
    String title, {
    String? description,
    TaskState state = TaskState.undone,
    bool isDeleted = false,
  }) : title = signal(title),
       description = signal(description),
       state = signal(state),
       isDeleted = signal(isDeleted);

  final int id;
  final Signal<String> title;
  final Signal<String?> description;
  final Signal<TaskState> state;
  final Signal<bool> isDeleted;
}
