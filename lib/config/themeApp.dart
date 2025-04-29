import 'package:flutter/material.dart';

class ThemeApp {
  static final theme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFFB246),
      onPrimary: Colors.black,
      secondary: Color(0xFFFEFF99),
      onSecondary: Color(0xFF49454F),
      tertiary: Color(0xFFC98311),
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.grey[200]!,
      onSurface: Colors.black,
    ),
  );
}
