import 'package:flutter/material.dart';
import 'package:schedium/schedium.dart' as schedium;
import 'package:signals_flutter/signals_flutter.dart';
import 'package:snowflake_dart/snowflake_dart.dart';
import 'screens.dart' as screens;
import 'package:schedium/model/model.dart' as model;
import 'package:schedium/ui/theme/palette.dart';
import '../widgets/task/task_tile.dart';

class Home extends schedium.Widget {
  const Home(super.appState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final task = model.PersistentTask(
            Snowflake(nodeId: 0).generate(),
            "New Task",
          );
          appState.tasks.add(task);
          appState.navigation.history.add(screens.Task(appState, data: task));
        },
        child: const Icon(Icons.add),
      ),
      body: SignalBuilder(
        builder: (context) {
          final tasks = appState.tasks.value
              .where((t) => !t.isDeleted.value)
              .toList();
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                'No tasks yet',
                style: TextStyle(color: Palette.muted),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskTile(
                task: task,
                onTap: () {
                  appState.navigation.history.add(
                    screens.Task(appState, data: task),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
