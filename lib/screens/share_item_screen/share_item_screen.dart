import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/app_image/app_image_circular.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ShareItemScreen extends StatelessWidget {
  const ShareItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Share Item"),
      body: Column(children: [UserCard(), UserCard(), UserCard()]),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppImageCircular(
                path: AssetsImagesPath.instance.person,
                width: AppSize.width(value: 44),
                height: AppSize.width(value: 44),
              ),
              Gap(width: AppSize.width(value: 14)),
              AppText(
                data: "Suporna Talukdar",
                fontSize: AppSize.width(value: 18),
                fontWeight: FontWeight.w400,
                color: AppColors.instance.black300,
              ),
            ],
          ),
          ConnectBtn(
            onTap: () {
              Get.toNamed(AppRoutes.instance.shareUserItemScreen);
            },
          ),
        ],
      ),
    );
  }
}

class ConnectBtn extends StatelessWidget {
  final Function()? onTap;
  const ConnectBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.instance.purple_600,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          AppImage(
            path: AssetsIconsPath.instance.addUserWhite,
            width: AppSize.width(value: 14),
            height: AppSize.width(value: 14),
          ),
          Gap(width: AppSize.width(value: 8)),
          GestureDetector(
            onTap: onTap,
            child: AppText(
              data: "Connect",
              fontSize: AppSize.width(value: 14),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.white300,
            ),
          ),
        ],
      ),
    );
  }
}
