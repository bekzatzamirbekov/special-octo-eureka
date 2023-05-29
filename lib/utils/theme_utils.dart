import 'package:flutter/material.dart';

class ThemeManager {
  static bool isDarkModeEnabled = true;

  static ThemeData getTheme() {
    return isDarkModeEnabled ? ThemeData.dark() : ThemeData.light();
  }

  static void toggleDarkMode(bool value) {
    isDarkModeEnabled = value;
  }
}


MaterialColor myColor = const MaterialColor(0xFF009987, {
  50: Color(0xFFE0F7FA),
  100: Color(0xFFB3E5FC),
  200: Color(0xFF80D8FF),
  300: Color(0xFF4DD0E1),
  400: Color(0xFF26C6DA),
  500: Color(0xFF00BCD4),
  600: Color(0xFF00ACC1),
  700: Color(0xFF0097A7),
  800: Color(0xFF00838F),
  900: Color(0xFF006064),
});
