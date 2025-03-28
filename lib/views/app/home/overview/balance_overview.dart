import 'package:dayang/helper/format_balance.dart';
import 'package:dayang/provider/provider.dart';
import 'package:dayang/ui/colors.dart';
import 'package:dayang/views/app/home/overview/balance_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget balanceOverview(BuildContext context) {
  final appProvider = Provider.of<AppProvider>(context);

  return Container(
    decoration: BoxDecoration(
      color: colorGray,
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
