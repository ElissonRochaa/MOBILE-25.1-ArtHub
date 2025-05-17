import 'package:flutter/material.dart';
import 'package:arthub/config/themeApp.dart';

class ThemeAppProvider with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData get themeData =>
      _isDarkMode ? ThemeApp.darkTheme : ThemeApp.lightTheme;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
