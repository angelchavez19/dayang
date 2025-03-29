import 'package:dayang/provider/provider.dart';
import 'package:dayang/views/app/transactions/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget transactionsBuilder(Future<void> transactionsFuture) {
  return FutureBuilder(
    future: transactionsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      }

      final appProvider = Provider.of<AppProvider>(context, listen: false);

      if (appProvider.transactions.isEmpty) {
        return const Center(child: Text("No transactions found."));
      }

      return Padding(
        padding: EdgeInsets.only(top: 60, bottom: 16, left: 10, right: 10),
        child: ListView.builder(
          itemCount: appProvider.transactions.length,
          itemBuilder: (context, index) {
            return TransactionItem(
              transaction: appProvider.transactions[index],
            );
          },
        ),
      );
    },
  );
}
