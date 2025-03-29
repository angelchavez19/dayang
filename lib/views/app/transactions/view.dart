import 'package:dayang/provider/provider.dart';
import 'package:dayang/ui/transaction_form.dart';
import 'package:dayang/views/app/transactions/builder/categories.dart';
import 'package:dayang/views/app/transactions/builder/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTransactionsView extends StatefulWidget {
  const AppTransactionsView({super.key});

  @override
  State<AppTransactionsView> createState() => _AppTransactionsViewState();
}

class _AppTransactionsViewState extends State<AppTransactionsView> {
  int filter = 0;
  late Future<void> _transactionsFuture;
  late Future<void> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _loadTransactions(0);
    _categoriesFuture = _loadCategories();
  }

  Future<void> _loadTransactions(int categoryId) async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    if (categoryId != 0) {
      return appProvider.updateUserTransactions(categoryId: categoryId);
    }
    return appProvider.updateUserTransactions();
  }

  Future<void> _loadCategories() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return appProvider.updateUserCategories();
  }

  Future<void> _addTransaction() async {
    await showTransactionDialog(context);
    setState(() {
      _transactionsFuture = _loadTransactions(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        categorybuilder(filter, _categoriesFuture, (value) {
          setState(() {
            filter = value;
            _transactionsFuture = _loadTransactions(value);
          });
        }),
        transactionsBuilder(_transactionsFuture),
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
