import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ItemTrackerWidget extends StatelessWidget {
  final Function()? onTap;

  const ItemTrackerWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: AppSize.width(value: 6)),
            padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 6)),
            width: AppSize.width(value: double.infinity),
            child: Stack(
              children: [
                Row(
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
                          color: AppColors.instance.black400,
                        ),
                        SizedBox(height: AppSize.width(value: 6)),
                        Row(
                          children: [
                            AppText(
                              data: "1235 New York, JFK Airport",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.black200,
                            ),
                            Gap(width: AppSize.width(value: 8)),
                            Icon(
                              Icons.pix,
                              size: AppSize.width(value: 8),
                              color: AppColors.instance.black200,
                            ),
                            Gap(width: AppSize.width(value: 8)),
                            AppText(
                              data: "Now",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.black200,
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
                              color: AppColors.instance.black200,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: AppSize.width(value: 8),
                  right: AppSize.width(value: 8),
                  child: Row(
                    children: [
                      AppImage(
                        path: AssetsIconsPath.instance.navigateIcon,
                        width: AppSize.width(value: 14),
                        height: AppSize.width(value: 14),
                      ),
                      Gap(width: AppSize.width(value: 4)),
                      AppText(
                        data: "With you",
                        fontSize: AppSize.width(value: 12),
                        fontWeight: FontWeight.w500,
                        color: AppColors.instance.black300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
