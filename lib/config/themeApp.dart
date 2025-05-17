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

  static final darkTheme = ThemeData(
    fontFamily: 'SignikaNegative',
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 90, 9, 190),
      onPrimary: Colors.black,
      secondary: Color.fromARGB(255, 207, 50, 205),
      onSecondary: Color(0xFF49454F),
      tertiary: Color.fromARGB(255, 201, 57, 223),
      onTertiary: Color(0xFF4A4459),
      error: Colors.red,
      onError: const Color.fromARGB(255, 124, 124, 124),
      surface: const Color.fromARGB(255, 31, 31, 31)!,
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
