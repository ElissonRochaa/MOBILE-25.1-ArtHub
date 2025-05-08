import 'package:flutter/material.dart';

class ThemeApp {
  static final theme = ThemeData(
    fontFamily: 'SignikaNegative',
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFFB246),
      onPrimary: Colors.black,
      secondary: Color(0xFFFEFF99),
      onSecondary: Color(0xFF49454F),
      tertiary: Color(0xFFC98311),
      onTertiary: Color(0xFF4A4459),
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.grey[200]!,
      onSurface: Colors.black,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32),
      displayMedium: TextStyle(fontSize: 24),
      titleLarge: TextStyle(fontSize: 20),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 15),
      labelLarge: TextStyle(fontSize: 14),
      labelSmall: TextStyle(fontSize: 12),
    ),
  );
}
