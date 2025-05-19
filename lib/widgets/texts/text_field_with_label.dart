import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String lebelText;
  final TextEditingController? controller;
  final String? trailingIcon;
  final String? hintText;
  final double? imgWidth;
  final double? imgHeight;
  final double? width; 
  final TextInputType? inputType;// New width parameter with optional value

  const TextFieldWithLabel({
    super.key,
    this.controller,
    this.trailingIcon,
    this.hintText,
    this.imgWidth,
    this.imgHeight,
    this.width,
    required this.lebelText, this.inputType, // Accept the width parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSize.width(value: 10),
      children: [
        AppText(
          data: lebelText,
          fontSize: AppSize.width(value: 14),
          fontWeight: FontWeight.w500,
          color: AppColors.instance.black400,
        ),
        Container(
          width:
              width ??
              double
                  .infinity, // Default to double.infinity if no width is provided
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.instance.black100),
            color: AppColors.instance.white50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            keyboardType: inputType ?? TextInputType.none,
            controller: controller, // Use the provided controller
            decoration: InputDecoration(

              border: InputBorder.none,
              hintText: hintText ?? 'HintText',
              hintStyle: TextStyle(color: AppColors.instance.white700),
              suffixIcon:
                  trailingIcon != null
                      ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: AppImage(
                          path: trailingIcon,
                          width: imgWidth ?? 24,
                          height: imgHeight ?? 24,
                        ),
                      )
                      : null, // Only show icon if trailingIcon is not null
            ),
          ),
        ),
      ],
    );
  }
}
