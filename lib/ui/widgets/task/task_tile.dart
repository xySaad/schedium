import 'package:flutter/material.dart';
import 'package:schedium/model/model.dart' as model;
import 'package:schedium/ui/theme/palette.dart';
import 'package:schedium/ui/widgets/state_chip.dart';
import 'package:signals_flutter/signals_flutter.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.onTap});

  final model.Task task;
  final VoidCallback onTap;

  void toggleState(model.State a, b) {
    final state = task.state;
    state.value = state.value == a ? b : a;
  }

  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      builder: (context) {
        final state = task.state.value;
        final title = task.title.value;
        final description = task.description.value;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: Palette.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: state.color, width: 1),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(12),
                mouseCursor: SystemMouseCursors.click,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    spacing: 12,
                    children: [
                      StateChip(
                        icon: state.icon,
                        activeColor: state.color,
                        isActive: true,
                        onTap: () =>
                            toggleState(model.State.undone, model.State.done),
                        onLongPress: () => toggleState(
                          model.State.ignored,
                          model.State.undone,
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: state == model.State.ignored
                                    ? Palette.muted
                                    : Palette.text,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                decoration: state == model.State.done
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Palette.muted,
                              ),
                            ),
                            if (description != null &&
                                description.isNotEmpty) ...[
                              const SizedBox(height: 3),
                              Text(
                                description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Palette.muted,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: Palette.muted,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
