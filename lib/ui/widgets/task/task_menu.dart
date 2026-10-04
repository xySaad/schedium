import 'package:flutter/material.dart';
import 'package:schedium/model/model.dart' as model;
import 'package:schedium/schedium.dart' as schedium;
import 'package:schedium/ui/dialogs/confirmation_dialog.dart';
import 'package:schedium/ui/theme/palette.dart';
import 'package:signals_flutter/signals_flutter.dart';

enum TaskMenuAction { delete }

class TaskMenu extends schedium.Widget {
  const TaskMenu(super.appState, {super.key, required this.task});

  final model.TaskModel task;

  Future<void> confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => ConfirmationDialog(
        title: 'Delete task?',
        description:
            '"${task.title.peek()}" will be removed from your task list.',
        confirmLabel: 'Delete',
      ),
    );
    final confirmed = result ?? false;
    if (!confirmed) return;

    final history = appState.navigation.history;
    history.removeLast();
    task.isDeleted.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TaskMenuAction>(
      icon: const Icon(Icons.more_vert_rounded, color: Palette.muted),
      tooltip: 'Task options',
      color: Palette.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Palette.outline, width: 1),
      ),
      onSelected: (action) {
        switch (action) {
          case TaskMenuAction.delete:
            confirmDelete(context);
        }
      },
      itemBuilder: (menuContext) => [
        const PopupMenuItem<TaskMenuAction>(
          value: TaskMenuAction.delete,
          child: Row(
            spacing: 8,
            children: [
              Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
                size: 20,
              ),
              Text(
                'Delete',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
