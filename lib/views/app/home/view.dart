import 'package:dayang/provider/provider.dart';
import 'package:dayang/views/app/home/actions/bar.dart';
import 'package:dayang/views/app/home/overview/balance_overview.dart';
import 'package:dayang/views/app/transactions/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppHomeView extends StatelessWidget {
  const AppHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    return FutureBuilder(
      future: appProvider.updateUserBalance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        return Padding(
          padding: EdgeInsets.only(top: 16, left: 10, right: 10),
          child: Column(
            children: [
              balanceOverview(context),
              SizedBox(height: 18),
              actionsBar(context),
              Expanded(child: TransactionList()),
            ],
          ),
        );
      },
    );
  }
}

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late Future<void> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return appProvider.updateUserTransactions(limit: 5);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _transactionsFuture,
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
    );
  }
}
