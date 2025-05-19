import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class TitledescriptionWidget extends StatelessWidget {
  final String title;
  final String descreption;
  const TitledescriptionWidget({
    super.key,
    required this.title,
    required this.descreption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          data: title,
          fontSize: AppSize.width(value: 14),
          fontWeight: FontWeight.w400,
          color: AppColors.instance.black400,
        ),
        Gap(height: AppSize.width(value: 10)),
        AppText(
          data: descreption,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.instance.black300,
        ),
      ],
    );
  }
}