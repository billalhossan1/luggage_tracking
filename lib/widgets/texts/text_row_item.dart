import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';



class TextRowItem extends StatelessWidget {
  final String text1;
  final String text2;
  final Color? text2Color;

  const TextRowItem({
    super.key,
    required this.text1,
    required this.text2,
    this.text2Color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          data: text1,
          fontSize: AppSize.width(value: 14),
          fontWeight: FontWeight.w400,
          color: AppColors.instance.black300,
        ),
        Gap(width: 20,),
        Expanded(
          child: AppText(
            data: text2,
            fontSize: AppSize.width(value: 14),
            fontWeight: FontWeight.w400,
            color: text2Color ?? AppColors.instance.black300,
            maxLines: 1,
            overflow:TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

