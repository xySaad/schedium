import 'package:flutter/material.dart';
import 'package:schedium/ui/theme/palette.dart';

enum TaskState {
  undone(Icons.radio_button_unchecked_rounded, Palette.muted),
  done(Icons.check_circle_rounded, Palette.done),
  ignored(Icons.remove_circle_rounded, Palette.ignored);

  final IconData icon;
  final Color color;
  const TaskState(this.icon, this.color);
}
