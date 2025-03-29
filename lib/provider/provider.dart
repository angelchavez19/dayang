import 'package:dayang/database/helper.dart';
import 'package:dayang/types.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  UserBalance userBalance;
  late List<UserTransaction> transactions;
  late List<UserCategory> categories;

  AppProvider({required this.userBalance});

  ThemeMode themeMode = ThemeMode.dark;

  void themeToogle() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  Future<void> updateUserBalance() async {
    final db = DatabaseHelper();
    await db.database;

    userBalance = await db.getBalance();
    notifyListeners();
  }

  Future<void> updateUserTransactions({int? limit, int? categoryId}) async {
    final db = DatabaseHelper();
    await db.database;

    transactions = await db.getTransactions(limit, categoryId);
    notifyListeners();
  }

  Future<void> updateUserCategories() async {
    final db = DatabaseHelper();
    await db.database;

    categories = await db.getCategories();
    notifyListeners();
  }
}
