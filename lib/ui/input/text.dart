import 'package:dayang/ui/input/label.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const TextInputField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: controller, decoration: labelInput(label));
  }
}
