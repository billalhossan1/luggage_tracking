import 'package:flutter/material.dart';

class CustomTextField {
  static Widget build({
    required String hintText,
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: validator,  // Make sure this is passed in and used here
    );
  }
}
