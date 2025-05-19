import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class TextForCardHeadLine extends StatelessWidget {
  final String text;
  const TextForCardHeadLine({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          data: text,
          fontSize: AppSize.width(value: 18),
          fontWeight: FontWeight.w400,
          color: AppColors.instance.purple_500,
        ),
        SizedBox(),
      ],
    );
  }
}
