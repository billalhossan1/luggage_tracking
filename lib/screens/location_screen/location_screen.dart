import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/divider/app_divider.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.white50,
      appBar: CustomAppBar(title: ""),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: Column(
          spacing: AppSize.width(value: 20),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage(
              path: AssetsIconsPath.instance.locationIcon,
              width: AppSize.width(value: 24),
              height: AppSize.width(value: 24),
            ),
            Text.rich(
              TextSpan(
                text: 'Allow  "',
                style: TextStyle(
                  fontSize: AppSize.width(value: 24),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppConst.fontFamily1,
                  color: AppColors.instance.black300,
                ),
                children: [
                  TextSpan(
                    text: 'Trkli',
                    style: TextStyle(
                      fontSize: AppSize.width(value: 24),
                      fontWeight: FontWeight.w500,
                      fontFamily: AppConst.fontFamily1,
                      color: AppColors.instance.purple_500,
                    ),
                  ),
                  TextSpan(
                    text: '" to use your location?',
                    style: TextStyle(
                      fontSize: AppSize.width(value: 24),
                      fontWeight: FontWeight.w500,
                      fontFamily: AppConst.fontFamily1,
                      color: AppColors.instance.black300,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            AppText(
              data: "your location is used to accurate track your workouts",
              fontSize: AppSize.width(value: 14),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black200,
              textAlign: TextAlign.center,
            ),
            AppDivider(),
            AppImage(
              path: AssetsIconsPath.instance.locationImg,
              width: AppSize.width(value: 234),
              height: AppSize.width(value: 234),
            ),
            Gap(height: AppSize.width(value: 10)),
            Column(
              spacing: AppSize.width(value: 6),
              children: [
                AppCard(
                  filColor: AppColors.instance.white500,
                  child: Center(
                    child: AppText(
                      data: "Allow While Using App",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.black400,
                    ),
                  ),
                ),
                AppCard(
                  onTap: () {
                    Get.offAllNamed(AppRoutes.instance.signIn);
                  },
                  filColor: AppColors.instance.white500,
                  child: Center(
                    child: AppText(
                      data: "Allow Once",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.black400,
                    ),
                  ),
                ),
                AppCard(
                  filColor: AppColors.instance.white500,
                  child: Center(
                    child: AppText(
                      data: "Don't Allow",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.black400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
