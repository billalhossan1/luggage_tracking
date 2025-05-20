import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';
import 'package:luggage_tracking/widgets/texts/icon_text_row.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Account Setting"),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: Column(
          children: [
            Gap(height: AppSize.width(value: 12)),
            AppText(
              fontSize: AppSize.width(value: 14),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black200,
              textAlign: TextAlign.justify,
              data:
                  "Account setting notice volutpat adipiscing In nibh viverra ex sapien non sit Nunc Nunc libero, volutpat Donec Ut nisi urna tincidunt at, est. venenatis Praesent convallis. ex felis.",
            ),
            Gap(height: AppSize.width(value: 20)),
            IcontextRow(
              iconPath: AssetsIconsPath.instance.lock,
              text: "Change Password",
              onTap: () {
                Get.toNamed(AppRoutes.instance.changePasswordScreen);
              },
            ),
            Gap(height: AppSize.width(value: 8)),
            IcontextRow(
              iconPath: AssetsIconsPath.instance.trush,
              text: "Delete Account",
              onTap: () {
                Get.toNamed(AppRoutes.instance.deleteAccountScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
