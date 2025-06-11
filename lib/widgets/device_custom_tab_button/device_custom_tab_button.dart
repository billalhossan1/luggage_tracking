import 'package:flutter/material.dart';

import '../../const/app_colors.dart';
import '../../screens/device_screen/controller/device_screen_controller.dart';
import '../../utils/app_size.dart';
import '../texts/app_text.dart';

class DeviceCustomTabButton extends StatelessWidget {
  final int? value;
  final String? text;
  final bool isSelected;
  final DeviceScreenController controller;

  const DeviceCustomTabButton({
    super.key,
    required this.controller,
    required this.isSelected,
    this.value,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectItem(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 8),
          vertical: AppSize.width(value: 10),
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: AppText(
          data: text ?? "Tab",
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w500,
          color:
          isSelected
              ? AppColors.instance.black500
              : AppColors.instance.black200,
        ),
      ),
    );
  }
}