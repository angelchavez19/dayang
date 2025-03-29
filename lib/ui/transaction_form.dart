import 'package:dayang/database/helper.dart';
import 'package:dayang/provider/provider.dart';
import 'package:dayang/ui/colors.dart';
import 'package:dayang/ui/dialog.dart';
import 'package:dayang/ui/input/categories.dart';
import 'package:dayang/ui/input/decimal.dart';
import 'package:dayang/ui/input/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showTransactionDialog(BuildContext context) async {
  final TextEditingController controllerAmount = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final TextEditingController controllerCategory = TextEditingController();

  void closeDialog() {
    Navigator.of(context).pop();
  }

  AppProvider getProvider() {
    return Provider.of<AppProvider>(context, listen: false);
  }

  Future<void> saveTransaction() async {
    final balance = controllerAmount.text;
    final description = controllerDescription.text;
    final category = controllerCategory.text;

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

    double currentBalance = double.parse(balance) * 100;

    if (currentBalance == 0) {
      showCustomDialog(
        context,
        'Invalid field',
        'The balance must be different from zero.',
      );
      return;
    }

    if (description.isEmpty) {
      showCustomDialog(
        context,
        'Invalid field',
        'The description must not be empty.',
      );
      return;
    }

    int categoryId = int.parse(category);

    AppProvider provider = getProvider();
    final dbHelper = DatabaseHelper();
    await dbHelper.database;
    await dbHelper.registerTransaction(currentBalance, description, categoryId);
    await provider.updateUserBalance();
    await provider.updateUserTransactions();

    closeDialog();
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Transaction'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 14,
          children: [
            DecimalInputField(controller: controllerAmount, label: 'Amount'),
            TextInputField(
              controller: controllerDescription,
              label: 'Description',
            ),
            CategoriesSelectorField(
              controller: controllerCategory,
              fetchCategories: () async {
                AppProvider provider = getProvider();
                await provider.updateUserCategories();
                return provider.categories;
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(onPressed: saveTransaction, child: Text('Save')),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(colorGray2),
            ),
            onPressed: closeDialog,
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
