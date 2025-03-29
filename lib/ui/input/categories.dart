import 'package:dayang/types.dart';
import 'package:flutter/material.dart';

class CategoriesSelectorField extends StatefulWidget {
  final TextEditingController controller;
  final Future<List<UserCategory>> Function() fetchCategories;

  const CategoriesSelectorField({
    super.key,
    required this.controller,
    required this.fetchCategories,
  });

  @override
  State<CategoriesSelectorField> createState() =>
      _CategoriesSelectorFieldState();
}

class _CategoriesSelectorFieldState extends State<CategoriesSelectorField> {
  late Future<List<UserCategory>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = widget.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No categories found"));
        }

        return DropdownButtonFormField<int>(
          value:
              widget.controller.text.isNotEmpty
                  ? int.tryParse(widget.controller.text)
                  : 1,
          items:
              snapshot.data!.map((UserCategory category) {
                return DropdownMenuItem<int>(
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
          onChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                widget.controller.text = newValue.toString();
              });
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        );
      },
    );
  }
}
