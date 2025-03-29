import 'package:dayang/provider/provider.dart';
import 'package:dayang/views/app/home/actions/bar.dart';
import 'package:dayang/views/app/home/overview/balance_overview.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Column(
            children: [
              balanceOverview(context),
              SizedBox(height: 18),
              actionsBar(context),
              SizedBox(height: 18),
            ],
          ),
        );
      },
    );
  }
}
