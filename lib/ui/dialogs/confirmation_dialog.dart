import 'package:flutter/material.dart';
import 'package:schedium/ui/theme/palette.dart';

/// Themed confirmation dialog. Pops with `true` when confirmed and `false`
/// when cancelled. Display it with `showDialog<bool>(...)`.
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    required this.confirmLabel,
    this.cancelLabel = 'Cancel',
    this.destructive = true,
  });

  final String title;
  final String description;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Palette.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Palette.outline, width: 1),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Palette.text,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        description,
        style: const TextStyle(color: Palette.muted, fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelLabel,
            style: const TextStyle(color: Palette.muted),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            confirmLabel,
            style: TextStyle(
              color: destructive ? Colors.redAccent : Palette.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
