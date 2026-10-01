import 'package:flutter/material.dart';
import 'package:schedium/ui/theme/palette.dart';
import 'package:signals_flutter/signals_flutter.dart';

class StateChip extends StatelessWidget {
  const StateChip({
    super.key,
    this.label,
    required this.icon,
    required this.activeColor,
    required this.isActive,
    this.onTap,
    this.onLongPress,
  });

  final String? label;
  final IconData icon;
  final Color activeColor;
  final bool isActive;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final pressed = signal(false);
    final bg = isActive ? activeColor.withValues(alpha: 0.15) : Palette.surface;
    final fg = isActive ? activeColor : Palette.muted;
    final border = isActive
        ? activeColor.withValues(alpha: 0.5)
        : Palette.outline;

    return SignalBuilder(
      builder: (context) => AnimatedScale(
        scale: pressed.value ? 0.90 : 1.0,
        duration: Duration(milliseconds: pressed.value ? 70 : 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: border, width: 1),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              onHighlightChanged: (v) => pressed.value = v,
              borderRadius: BorderRadius.circular(20),
              mouseCursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [
                    Icon(icon, size: 20, color: fg),
                    if (label case final label?)
                      Text(
                        label,
                        style: TextStyle(
                          color: fg,
                          fontSize: 13,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                          letterSpacing: 0.2,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
