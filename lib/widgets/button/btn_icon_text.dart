import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class BtnIconText extends StatelessWidget {
  final double? paddingHoriz;
  final double? paddingvert;
  final double? radius;
  final String? iconPath;
  final String? text;
  final Function()? onTap;
  final Color? filColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const BtnIconText({
    super.key,
    this.paddingHoriz,
    this.paddingvert,
    this.iconPath,
    this.text,
    this.onTap,
    this.filColor,
    this.radius,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: filColor ?? AppColors.instance.white500,
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: paddingHoriz ?? 10),
          vertical: AppSize.width(value: paddingvert ?? 8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null && iconPath!.isNotEmpty)
              AppImage(
                path: iconPath!,
                width: AppSize.width(value: 16),
                height: AppSize.width(value: 16),
                color: textColor ?? AppColors.instance.black400,
              ),
            if (iconPath != null && iconPath!.isNotEmpty)
              Gap(width: AppSize.width(value: 8)),
            AppText(
              data: text ?? "Edit",
              color: textColor ?? AppColors.instance.black400,
              fontSize: fontSize ?? AppSize.width(value: 14),
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
