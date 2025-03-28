import 'package:dayang/helper/format_balance.dart';
import 'package:dayang/provider/provider.dart';
import 'package:dayang/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget appHomeView(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
    child: Column(children: [balanceOverview(context)]),
  );
}

Widget balanceOverview(BuildContext context) {
  final appProvider = Provider.of<AppProvider>(context);

  return Container(
    decoration: BoxDecoration(
      color: colorGray,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 45,
            child: Text(
              'Balance Overview',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              balanceCard(
                'Current balance',
                formatBalance(appProvider.userBalance.balance),
                colorBlue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  balanceCard(
                    'Income',
                    formatBalance(appProvider.userBalance.income),
                    Colors.green,
                  ),
                  balanceCard(
                    'Expenses',
                    formatBalance(appProvider.userBalance.expenses),
                    colorRed,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget balanceCard(String title, String value, Color valueColor) {
  return Container(
    decoration: BoxDecoration(
      color: colorGray2,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '\$ $value',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
        ],
      ),
    ),
  );
}
