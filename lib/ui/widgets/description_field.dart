import 'package:flutter/material.dart';
import 'package:schedium/ui/theme/palette.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required this.controller,
    required this.onChanged,
  });
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Palette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Palette.outline, width: 1),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          color: Palette.text,
          fontSize: 15,
          height: 1.6,
        ),
        maxLines: null,
        minLines: 5,
        textInputAction: TextInputAction.newline,
        decoration: const InputDecoration(
          hintText: 'Add a description…',
          hintStyle: TextStyle(color: Palette.muted, fontSize: 15),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
      ),
    );
  }
}
