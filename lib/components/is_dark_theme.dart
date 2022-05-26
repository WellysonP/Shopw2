import 'package:flutter/material.dart';

class IsADarkTheme with ChangeNotifier {
  // IsADarkTheme() {
  //   loadTheme();
  //   notifyListeners();
  // }

  ThemeData themeData = ThemeData.dark();

  bool get isDark => themeData.brightness == Brightness.dark;

  void changeTheme() {
    if (isDark) {
      themeData = ThemeData.light();
    } else {
      themeData = ThemeData.dark();
    }
    // saveThemePreferences();
    notifyListeners();
  }

  // void saveThemePreferences() {
  //   SharedPreferences.getInstance().then((instance) {
  //     instance.setBool("isDark", isDark);
  //   });
  // }

  // Future<void> loadTheme() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey("isDark")) {
  //     themeType = ThemeData.dark();
  //   } else {
  //     themeType = ThemeData.light();
  //   }
  //   notifyListeners();
  // }
}
