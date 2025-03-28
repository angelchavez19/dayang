import 'package:dayang/types.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  UserBalance userBalance;

  AppProvider({required this.userBalance});

  ThemeMode themeMode = ThemeMode.dark;

  void themeToogle() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
