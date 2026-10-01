import 'package:flutter/material.dart';

import 'palette.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Palette.background,
    colorScheme: const ColorScheme.dark(
      primary: Palette.accent,
      onPrimary: Palette.background,
      surface: Palette.surface,
      onSurface: Palette.text,
    ),
    splashColor: Colors.white.withValues(alpha: 0.06),
    highlightColor: Colors.white.withValues(alpha: 0.04),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.accent,
      foregroundColor: Palette.background,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      shape: CircleBorder(),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Palette.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
  );
}
