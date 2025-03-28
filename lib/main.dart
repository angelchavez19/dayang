import 'package:dayang/database/helper.dart';
import 'package:dayang/provider/provider.dart';
import 'package:dayang/router/index.dart';
import 'package:dayang/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  await dbHelper.database;

  Map<String, dynamic> balance = await dbHelper.getBalance();

  runApp(
    ChangeNotifierProvider(
      create:
          (context) => AppProvider(
            balance: balance["balance"],
            init: balance["init"] == 0 ? false : true,
          ),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: appProvider.themeMode,
      routerConfig: router,
    );
  }
}
