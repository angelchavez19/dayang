import 'package:dayang/provider/provider.dart';
import 'package:dayang/ui/transaction_form.dart';
import 'package:dayang/views/app/transactions/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTransactionsView extends StatefulWidget {
  const AppTransactionsView({super.key});

  @override
  State<AppTransactionsView> createState() => _AppTransactionsViewState();
}

class _AppTransactionsViewState extends State<AppTransactionsView> {
  late Future<void> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return appProvider.updateUserTransactions();
  }

  Future<void> _addTransaction() async {
    await showTransactionDialog(context);
    setState(() {
      _transactionsFuture = _loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: _transactionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final appProvider = Provider.of<AppProvider>(
              context,
              listen: false,
            );

            if (appProvider.transactions.isEmpty) {
              return const Center(child: Text("No transactions found."));
            }

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
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
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _addTransaction,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
