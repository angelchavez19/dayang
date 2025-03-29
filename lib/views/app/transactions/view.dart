import 'package:dayang/provider/provider.dart';
import 'package:dayang/views/app/transactions/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTransactionsView extends StatelessWidget {
  const AppTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    return FutureBuilder(
      future: appProvider.updateUserTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (appProvider.transactions.isEmpty) {
          return const Center(child: Text("No transactions found."));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
}
