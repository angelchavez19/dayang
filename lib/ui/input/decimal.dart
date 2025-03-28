import 'package:dayang/ui/input/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecimalInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const DecimalInputField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final List<FilteringTextInputFormatter> formatters = [
      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$')),
    ];

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      inputFormatters: formatters,
      decoration: labelInput(
        label,
        SizedBox(
          width: 48,
          height: 48,
          child: Center(child: Text('\$', style: TextStyle(fontSize: 20))),
        ),
        // Icon(Icons.numbers),
      ),
    );
  }
}
