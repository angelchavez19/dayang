import 'package:flutter/material.dart';

InputDecoration labelInput(String labeltext, Widget? prefixIcon) {
  return InputDecoration(
    labelText: labeltext,
    border: OutlineInputBorder(),
    prefixIcon: prefixIcon,
  );
}
