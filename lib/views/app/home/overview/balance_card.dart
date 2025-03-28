import 'package:dayang/ui/colors.dart';
import 'package:flutter/material.dart';

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
