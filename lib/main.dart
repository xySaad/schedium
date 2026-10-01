import 'package:flutter/material.dart';
import 'package:schedium/model/app_state.dart';
import 'package:schedium/model/task/task_service.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'ui/screens/screens.dart' as screens;
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final taskService = TaskService();
  final initialTasks = await taskService.loadTasks();

  final appState = AppState(
    title: signal('Schedium'),
    tasks: Signal(initialTasks),
  );

  effect(() {
    final tasks = appState.tasks.value;
    for (final task in tasks) {
      task.title.value;
      task.description.value;
      task.state.value;
      task.isDeleted.value;
    }
    taskService.saveTasks(tasks);
  });

  appState.navigation.history.add(screens.Home(appState));
  runApp(SchediumApp(appState));
}
