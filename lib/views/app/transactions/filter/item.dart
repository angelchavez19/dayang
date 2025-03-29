import 'package:dayang/ui/colors.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final int value;
  final String text;
  final bool isSelected;
  final void Function(int value) onSelected;

  const FilterItem({
    super.key,
    required this.value,
    required this.text,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.all(0),
          ),
          backgroundColor: WidgetStatePropertyAll<Color>(
            isSelected ? colorPrimary : colorGray,
          ),
        ),
        onPressed: () => onSelected(value),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
