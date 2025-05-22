import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class IconTextColumn extends StatelessWidget {
  final String? iconPath;
  final String? text;
  final Function()? onTap;
  const IconTextColumn({super.key, this.iconPath, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSize.width(value: 26),
          horizontal: AppSize.width(value: 16),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.instance.white200,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1), // Shadow color
              offset: Offset(-4, 4), // x: left (-), y: bottom (+)
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              path: iconPath ?? AssetsIconsPath.instance.share,
              width: AppSize.width(value: 20),
              height: AppSize.width(value: 20),
            ),
            Gap(height: AppSize.width(value: 8)),
            AppText(
              data: text ?? "Start Sound",
              fontSize: AppSize.width(value: 14),
              fontWeight: FontWeight.w500,
              color: AppColors.instance.black400,
            ),
          ],
        ),
      ),
    );
  }
}
