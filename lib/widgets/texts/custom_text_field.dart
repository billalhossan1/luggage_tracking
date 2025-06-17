import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';

class CustomTextField {
  static Widget build({
    Color? fillColor,
    bool readonly = false, // default value set to false
    String? hintText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    GestureTapCallback? onTap, // New parameter to handle onTap
  }) {
    return TextFormField(
      readOnly: readonly, // Make the text field readonly if needed
      controller: controller ?? TextEditingController(),
      style: TextStyle(color: AppColors.instance.black400),
      decoration: InputDecoration(
        fillColor: fillColor,
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
              return '${hintText ?? "Field"} is required'; // Use "Field" as fallback
            }
            return null;
          },
      onTap: onTap, // Handle the tap event to trigger a date picker or custom actions
    );
  }
}
