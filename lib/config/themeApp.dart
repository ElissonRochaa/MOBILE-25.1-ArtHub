import 'package:flutter/material.dart';

class ThemeApp {
  static final lightTheme = ThemeData(
    fontFamily: 'SignikaNegative',
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFFB246),
      onPrimary: Colors.black,
      secondary: Color(0xFFFEFF99),
      onSecondary: Color(0xFF49454F),
      tertiary: Color(0xFFC98311),
      onTertiary: Color.fromRGBO(10, 10, 10, 0.3),
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
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

  static final darkTheme = ThemeData(
    fontFamily: 'SignikaNegative',
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF7D4AFF),
      onPrimary: Colors.white,
      secondary: Color(0xFF9A7AFF),
      onSecondary: const Color.fromARGB(255, 58, 52, 52),
      tertiary: Color(0xFF5E2DB3),
      onTertiary: Colors.black,
      error: const Color.fromARGB(255, 1, 7, 44),
      onError: const Color.fromARGB(255, 62, 55, 55),
      surface: Color(0xFF18181B),
      onSurface: const Color.fromARGB(255, 0, 0, 0),
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
