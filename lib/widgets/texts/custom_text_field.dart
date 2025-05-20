import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';

class CustomTextField {
  static Widget build({String? hintText, TextEditingController? controller}) {
    return TextField(
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
    );
  }
}
