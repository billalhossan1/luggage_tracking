import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class FindNearby extends StatelessWidget {
  const FindNearby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Find NearBy"),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            AssetsImagesPath
                .instance
                .nearbyBg, // Make sure this image path is correct
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 14)),
            width: AppSize.width(value: double.infinity),

            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: AppSize.width(value: 6),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.width(value: 6),
                    ),
                    width: AppSize.width(value: double.infinity),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppImage(
                          path: AssetsIconsPath.instance.product3,
                          width: AppSize.width(value: 40),
                          height: AppSize.width(value: 40),
                        ),
                        Gap(width: AppSize.width(value: 8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              data: "Big Samsonite Luggage",
                              fontSize: AppSize.width(value: 14),
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.white50,
                            ),
                            SizedBox(height: AppSize.width(value: 6)),
                            Row(
                              children: [
                                AppText(
                                  data: "1235 New York, JFK Airport",
                                  fontSize: AppSize.width(value: 12),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.instance.white50,
                                ),
                                Gap(width: AppSize.width(value: 8)),
                                Icon(
                                  Icons.pix,
                                  size: AppSize.width(value: 8),
                                  color: AppColors.instance.white50,
                                ),
                                Gap(width: AppSize.width(value: 8)),
                                AppText(
                                  data: "Now",
                                  fontSize: AppSize.width(value: 12),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.instance.white50,
                                ),
                              ],
                            ),
                            SizedBox(height: AppSize.width(value: 6)),
                            Row(
                              children: [
                                AppImage(
                                  path: AssetsIconsPath.instance.share,
                                  width: AppSize.width(value: 14),
                                  height: AppSize.width(value: 14),
                                ),
                                Gap(width: AppSize.width(value: 8)),
                                AppText(
                                  data: "Shared with Shakh Hasina",
                                  fontSize: AppSize.width(value: 12),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.instance.white50,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: AppSize.width(value: 154),
              height: AppSize.width(value: 154),
              child: AppImage(
                path: AssetsIconsPath.instance.navigatorIndicator,
              ),
            ),
          ),

          // Overlay content
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 120.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppImage(
                      path: AssetsIconsPath.instance.navigateIcon,
                      width: AppSize.width(value: 30),
                      height: AppSize.width(value: 30),
                    ),
                    Gap(width: AppSize.width(value: 10)),
                    AppText(
                      data: "23 ft",
                      fontSize: AppSize.width(value: 56),
                      fontWeight: FontWeight.w500,
                      color: AppColors.instance.black500,
                    ),
                  ],
                ),

                Gap(height: AppSize.width(value: 4)),
                AppText(
                  data: "Nearby",
                  fontSize: AppSize.width(value: 42),
                  fontWeight: FontWeight.w500,
                  color: AppColors.instance.black500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
