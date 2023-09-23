import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  void changeTheme(newMode) {
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    notifyListeners();
  }

  isDark() {
    return appTheme == ThemeMode.dark ? true : false;
  }

  Locale locale = Locale('en');

  void changeLanguage(newLanguage) {
    if (locale == newLanguage) {
      return;
    }
    locale = newLanguage;
    notifyListeners();
  }

  isEnglish() {
    return locale == Locale('en') ? true : false;
  }
}
