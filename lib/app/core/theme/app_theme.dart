import 'package:flutter/material.dart';

part 'app_color_scheme.dart';

final appTheme = ThemeData(
  useMaterial3: false,
  colorScheme: _appColorScheme,
  listTileTheme: ListTileThemeData(
    minTileHeight: 55,
    tileColor: _appColorScheme.surface,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: _appColorScheme.onSurface.withValues(alpha: .7),
    ),
    minLeadingWidth: 14,
  ),
);
