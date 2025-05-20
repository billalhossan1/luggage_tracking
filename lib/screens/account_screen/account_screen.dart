import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_image/app_image_circular.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';
import 'package:luggage_tracking/widgets/texts/icon_text_row.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Account", showLeading: false),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSize.width(value: 12),
            children: [
              AppCard(
                onTap: () {
                  Get.toNamed(AppRoutes.instance.profileDetailsScreen);
                },
                child: Column(
                  spacing: AppSize.width(value: 8),
                  children: [
                    AppImageCircular(
                      path: AssetsImagesPath.instance.person,
                      width: AppSize.width(value: 72),
                      height: AppSize.width(value: 72),
                      fit: BoxFit.cover,
                    ),
                    AppText(
                      data: "Mr. Spatch",
                      fontSize: AppSize.width(value: 18),
                      fontWeight: FontWeight.w500,
                      color: AppColors.instance.black500,
                    ),
                    AppText(
                      data: "Spatch@gmail,com",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.purple_500,
                    ),
                  ],
                ),
              ),

              IcontextRow(
                iconPath: AssetsIconsPath.instance.wishList,
                text: "Wish list",
                onTap: () {
                  Get.toNamed(AppRoutes.instance.wishListScreen);
                },
              ),
              IcontextRow(
                iconPath: AssetsIconsPath.instance.dealCart,
                text: "Dealing History ",
                onTap: () {
                  Get.toNamed(AppRoutes.instance.dealingHistoryScreen);
                },
              ),
              IcontextRow(
                iconPath: AssetsIconsPath.instance.setting,
                text: "Account Setting",
              ),
              IcontextRow(
                iconPath: AssetsIconsPath.instance.about,
                text: "About",
                onTap: () {
                  Get.toNamed(AppRoutes.instance.acoutScreen);
                },
              ),
              IcontextRow(
                iconPath: AssetsIconsPath.instance.workFunc,
                text: "Work Functionality",
              ),
              IcontextRow(
                iconPath: AssetsIconsPath.instance.terms,
                text: "Terms & Conditions",
                onTap: () {
                  Get.toNamed(AppRoutes.instance.termsAndCondionScreen);
                },
              ),
              IcontextRow(iconPath: AssetsIconsPath.instance.faq, text: "FAQ"),
              IcontextRow(
                iconPath: AssetsIconsPath.instance.feedback,
                text: "Feedback",
              ),
              IcontextRow(
                iconPath: AssetsIconsPath.instance.logout,
                text: "Log Out",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
