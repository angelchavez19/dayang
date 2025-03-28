import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  double balance;
  bool init;

  AppProvider({required this.balance, required this.init});

  ThemeMode themeMode = ThemeMode.dark;

  void themeToogle() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
