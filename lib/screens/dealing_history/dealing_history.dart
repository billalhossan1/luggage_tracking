import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class DealingHistoryScreen extends StatelessWidget {
  const DealingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Dealing History"),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: Column(
          children: [
            AppCard(
              child: Row(
                children: [
                  // First column: Image
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: AppImage(
                        path: AssetsImagesPath.instance.product1,
                        width: AppSize.width(value: 72),
                        height: AppSize.width(value: 72),
                      ),
                    ),
                  ),

                  // Second column: Order details
                  Expanded(
                    flex: 2,
                    child: Column(
                      spacing: AppSize.width(value: 8),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          data: "Order No: #1458118",
                          fontSize: AppSize.width(value: 14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.instance.black200,
                        ),
                        AppText(
                          data: "Luggage Tag",
                          fontSize: AppSize.width(value: 14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.instance.black400,
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "Qty ",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.black200,
                            ),
                            AppText(
                              data: "3",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.blue1,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "Total Price ",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.black200,
                            ),
                            AppText(
                              data: ": \$3",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.blue1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Third column: Status
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: AppSize.width(
                        value: 72,
                      ), // Match the image height
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            data: "Completed",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.green1,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.width(value: 10),
                              vertical: AppSize.width(value: 9),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.instance.white500,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: AppText(
                              data: "Buy Again",
                              fontSize: AppSize.width(value: 13),
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.purple_500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // AppCard(
            //   child: Row(
            //     children: [AppImage(path: AssetsImagesPath.instance.product2)],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
