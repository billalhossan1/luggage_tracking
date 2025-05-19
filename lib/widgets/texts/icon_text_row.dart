import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class IcontextRow extends StatelessWidget {
  final String? iconPath;
  final String? text;
  final Function()? onTap;
  const IcontextRow({super.key, this.iconPath, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 20),
          vertical: AppSize.width(value: 10),
        ),
        width: AppSize.width(value: double.infinity),
        decoration: BoxDecoration(
          color: AppColors.instance.white50,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          spacing: AppSize.width(value: 16),
          children: [
            AppImage(
              path: iconPath ?? AssetsIconsPath.instance.wishList,
              width: AppSize.width(value: 20),
              height: AppSize.width(value: 20),
            ),
            AppText(
              data: text ?? "Wish list",
              fontSize: AppSize.width(value: 18),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black300,
            ),
          ],
        ),
      ),
    );
  }
}
