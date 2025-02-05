import 'package:flutter/material.dart';

part 'app_color_scheme.dart';

final appTheme = ThemeData(
  useMaterial3: false,
  colorScheme: _appColorScheme,
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return _appColorScheme.primary;
          }
          return _appColorScheme.onPrimary;
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return _appColorScheme.onSurface;
          }
          return _appColorScheme.onPrimary;
        },
      ),
      backgroundColor: WidgetStateColor.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return _appColorScheme.onPrimary;
          }
          return _appColorScheme.onSurface.withValues(alpha: .3);
        },
      ),
    ),
  ),
);
