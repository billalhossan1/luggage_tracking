import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';

class CustomTextField {
  static Widget build({
    String? hintText,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller ?? TextEditingController(),
      style: TextStyle(color: AppColors.instance.black400),
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color: AppColors.instance.black400),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.instance.white600),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.instance.white600),
        ),
      ),
      cursorColor: AppColors.instance.white600,
      validator: validator ??
              (value) {
            if (value == null || value.trim().isEmpty) {
              return '$hintText is required';
            }
            return null;
          },
    );
  }
}
