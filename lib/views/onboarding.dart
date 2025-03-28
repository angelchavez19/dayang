import 'package:dayang/database/helper.dart';
import 'package:dayang/provider/provider.dart';
import 'package:dayang/ui/dialog.dart';
import 'package:dayang/ui/input/decimal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final TextEditingController _controllerBalance = TextEditingController();

  void goApp() {
    context.go('/app');
  }

  void saveData() async {
    final balance = _controllerBalance.text;
    if (balance.isEmpty) {
      showCustomDialog(
        context,
        'Invalid field',
        'The field must not be empty.',
      );
      return;
    }
    if (!RegExp(r'^-?\d+(\.\d{1,2})?$').hasMatch(balance)) {
      showCustomDialog(
        context,
        'Invalid field',
        'Only signed decimal values with up to 2 decimal places are allowed.',
      );
      return;
    }

    final dbHelper = DatabaseHelper();
    await dbHelper.database;

    double currentBalance = double.parse(balance) * 100;

    await dbHelper.saveBalance(currentBalance);
    goApp();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (appProvider.init) {
        context.go('/app');
      }
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecimalInputField(controller: _controllerBalance, label: 'Balance'),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: saveData, child: Text("Save")),
            ),
          ],
        ),
      ),
    );
  }
}
