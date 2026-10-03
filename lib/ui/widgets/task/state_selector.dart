import 'package:flutter/material.dart';
import 'package:schedium/model/model.dart' as model;
import 'package:signals_flutter/signals_flutter.dart';
import '../state_chip.dart';

class StateSelector extends StatelessWidget {
  const StateSelector({super.key, required this.task});
  final model.Task task;

  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      builder: (context) {
        final current = task.state.value;
        return Row(
          spacing: 8,
          children: [
            for (final state in [model.TaskState.done, model.TaskState.ignored])
              StateChip(
                label: state.name,
                icon: state.icon,
                activeColor: state.color,
                isActive: current == state,
                onTap: () => task.state.value = current == state
                    ? model.TaskState.undone
                    : state,
              ),
          ],
        );
      },
    );
  }
}
