import 'package:flutter/material.dart';

enum ThemeModeType { light, dark }

class ThemeHelper with ChangeNotifier {
  ThemeData getLightTheme() {
    return ThemeData(
      fontFamily: 'YekanbBakh',
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      cardTheme: const CardTheme(
        color: Colors.white,
      ),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'YekanBakh',
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 41, 46, 54),
      ),
      scaffoldBackgroundColor: Color.fromARGB(255, 41, 46, 54),
      cardTheme: const CardTheme(
        color: Color.fromARGB(255, 46, 52, 64),
      ),
    );
  }
}

class ThemeModel with ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.light;

  ThemeMode get themeMode => _themeMode == ThemeModeType.light ? ThemeMode.light : ThemeMode.dark;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeModeType.light ? ThemeModeType.dark : ThemeModeType.light;
    notifyListeners();
  }
}
