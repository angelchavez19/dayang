import 'package:dayang/views/app/home/actions/bar.dart';
import 'package:dayang/views/app/home/overview/balance_overview.dart';
import 'package:flutter/material.dart';

Widget appHomeView(BuildContext context) {
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
}
