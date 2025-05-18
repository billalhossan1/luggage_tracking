import 'package:flutter/material.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class AccountCardWidget extends StatelessWidget {
  const AccountCardWidget({
    super.key,
    this.iconPath,
    required this.title,
    this.onTap,
    this.iconColor,
    this.trellingIcon,
    this.isLeadingShow = true,
    this.cardColor,
  });
  final String? iconPath;
  final String title;
  final void Function()? onTap;
  final Color? iconColor;
  final String? trellingIcon;
  final bool isLeadingShow;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSize.width(value: 52),
        decoration: BoxDecoration(
          // color: cardColor ?? AppColors.black500,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  isLeadingShow
                      ? AppImage(
                        width: AppSize.width(value: 16),
                        height: AppSize.width(value: 16),
                        path: iconPath ?? '',
                        iconColor: iconColor,
                      )
                      : SizedBox(),
                  Gap(width: 10),
                  AppText(
                    data: title,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    // color: AppColors.black500,
                  ),
                ],
              ),
              // AppImage(
              //   path: trellingIcon ?? AssetsIconsPath.arrowright,
              //   width: AppSize.width(value: 16),
              //   height: AppSize.width(value: 16),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
