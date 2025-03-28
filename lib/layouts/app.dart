import 'package:dayang/ui/colors.dart';
import 'package:dayang/views/app/home/view.dart';
import 'package:dayang/views/app/transactions.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text('Dayang: Track your finance'),
      ),
      body:
          <Widget>[
            appHomeView(context),
            appTransactionsView(context),
          ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: colorPrimary,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_outlined),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.swap_horiz),
            icon: Icon(Icons.swap_horiz_outlined),
            label: 'Transaction',
          ),
        ],
      ),
    );
  }
}
