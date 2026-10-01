import 'package:flutter/material.dart';
import 'package:schedium/ui/theme/palette.dart';

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      onTapOutside: (_) => onSubmitted(controller.text),
      style: const TextStyle(
        color: Palette.text,
        fontSize: 26,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      maxLines: null,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        hintText: 'Task title…',
        hintStyle: TextStyle(color: Palette.muted, fontSize: 26),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
