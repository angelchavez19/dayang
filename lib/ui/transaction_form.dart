import 'package:dayang/ui/colors.dart';
import 'package:flutter/material.dart';

Future<void> showTransactionDialog(BuildContext context) async {
  Future<void> saveTransaction() async {
    Navigator.of(context).pop();
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Transaction'),
        content: Text('Transaction form'),
        actions: [
          ElevatedButton(onPressed: saveTransaction, child: Text('Save')),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(colorGray2),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
