import 'package:dayang/provider/provider.dart';
import 'package:dayang/views/app/transactions/filter/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget categorybuilder(
  int filter,
  Future<void> categoriesFuture,
  void Function(int value) onSelected,
) {
  return FutureBuilder(
    future: categoriesFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      }

      final appProvider = Provider.of<AppProvider>(context, listen: false);

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SizedBox(
          height: 30,
          child: ListView.builder(
            itemCount: appProvider.categories.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return FilterItem(
                  value: 0,
                  text: 'All',
                  isSelected: filter == 0,
                  onSelected: onSelected,
                );
              }

              final category = appProvider.categories[index - 1];
              return FilterItem(
                value: category.id,
                text: category.name,
                isSelected: filter == index,
                onSelected: onSelected,
              );
            },
          ),
        ),
      );
    },
  );
}
