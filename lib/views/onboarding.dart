import 'package:dayang/ui/dialog.dart';
import 'package:dayang/ui/input/decimal.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final TextEditingController _controllerBalance = TextEditingController();

  void saveData() {
    final balance = _controllerBalance.text;
    if (balance.isEmpty) {
      showCustomDialog(
        context,
        'Invalid field',
        'The field must not be empty.',
      );
      return;
    }
    if (!RegExp(r'^-?\d*\.?\d*$').hasMatch(balance)) {
      showCustomDialog(
        context,
        'Invalid field',
        'The field must be a decimal number.',
      );
      return;
    }

    print(balance);
    print('double ${double.parse(balance)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecimalInputField(controller: _controllerBalance, label: 'Balance'),
            SizedBox(height: 50),
            ElevatedButton(onPressed: saveData, child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
