import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    appBarTheme: AppBarTheme(backgroundColor: Colors.pink),
    iconTheme: IconThemeData(color: Colors.pink),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.pink,
      extendedTextStyle: TextStyle(
        color: Colors.white,
      ),
      foregroundColor: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    appBarTheme: AppBarTheme(backgroundColor: Colors.pink),
    iconTheme: IconThemeData(color: Colors.pink),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.pink,
      extendedTextStyle: TextStyle(
        color: Colors.white,
      ),
      foregroundColor: Colors.white,
    ),
  );
}
