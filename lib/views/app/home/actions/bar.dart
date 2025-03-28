import 'package:dayang/ui/transaction_form.dart';
import 'package:flutter/material.dart';

Widget actionsBar(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              showTransactionDialog(context);
            },
            child: Row(
              spacing: 8,
              children: [
                Icon(Icons.add, size: 25),
                Text('Add Transaction', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
