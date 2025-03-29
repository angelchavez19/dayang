import 'package:dayang/helper/format_balance.dart';
import 'package:dayang/helper/format_datetime.dart';
import 'package:dayang/types.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final UserTransaction transaction;
  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ${formatBalance(transaction.amount)}',
                  style: TextStyle(
                    fontSize: 25,
                    color: transaction.amount >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$ ${formatBalance(transaction.currentBalance)}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                formatDateTime(transaction.date),
                style: TextStyle(fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                transaction.description,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
