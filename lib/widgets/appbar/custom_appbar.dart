import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showLeading = true, // default is true
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          // color: AppColors.instance.white50,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        child: AppBar(
          title: AppText(
            data: title,
            fontSize: AppSize.width(value: 18),
            fontWeight: FontWeight.w500,
            color: AppColors.instance.black500,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading:
              showLeading
                  ? GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: AppImage(path: AssetsIconsPath.instance.leftArrow),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
