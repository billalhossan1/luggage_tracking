import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/controller/tracker_controller.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/widgets/icon_text_column.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/widgets/item_tracker_widget.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/divider/app_divider.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class TrackerItemScreen extends StatelessWidget {
  const TrackerItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TrackerController controller = Get.put(TrackerController());

    return Scaffold(
      appBar: CustomAppBar(title: "Track Item"),
      body: GestureDetector(
        onTap: () {
          Get.bottomSheet(
            FractionallySizedBox(
              heightFactor: 0.6, // Use up to 90% of the screen height
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.instance.white50,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        data: "Items List",
                        fontSize: AppSize.width(value: 18),
                        fontWeight: FontWeight.w600,
                        color: AppColors.instance.black700,
                      ),
                      AppDivider(),
                      AppText(
                        data: "My Items",
                        fontSize: AppSize.width(value: 14),
                        fontWeight: FontWeight.w400,
                        color: AppColors.instance.black200,
                      ),
                      Gap(height: AppSize.width(value: 16)),

                      /// Items
                      Column(
                        children: List.generate(3, (index) {
                          return TrackItemCardSection(controller: controller);
                        }),
                      ),

                      Gap(height: AppSize.width(value: 16)),
                      AppText(
                        data: "My Items",
                        fontSize: AppSize.width(value: 14),
                        fontWeight: FontWeight.w400,
                        color: AppColors.instance.black200,
                      ),
                      Gap(height: AppSize.width(value: 16)),
                      Column(
                        children: List.generate(4, (index) {
                          return Column(
                            children: [
                              ItemTrackerWidget(
                                onTap: () {
                                  controller.toggleExpanded();
                                },
                              ),
                              Obx(
                                () =>
                                    controller.isExpanded.value
                                        ? AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          child: Column(
                                            children: [
                                              AppDivider(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: IconTextColumn(),
                                                  ),
                                                  Gap(
                                                    width: AppSize.width(
                                                      value: 8,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: IconTextColumn(
                                                      text: "Find Nearby",
                                                      iconPath:
                                                          AssetsIconsPath
                                                              .instance
                                                              .arrowGreen,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gap(
                                                height: AppSize.width(value: 8),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: IconTextColumn(
                                                      text: "Share Item",
                                                      iconPath:
                                                          AssetsIconsPath
                                                              .instance
                                                              .addUser,
                                                    ),
                                                  ),
                                                  Gap(
                                                    width: AppSize.width(
                                                      value: 8,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: IconTextColumn(
                                                      text: "Notification",
                                                      iconPath:
                                                          AssetsIconsPath
                                                              .instance
                                                              .bellRed,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                        : SizedBox.shrink(),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isScrollControlled: true,
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              AssetsImagesPath
                  .instance
                  .mapImg, // Make sure this image path is correct
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

class TrackItemCardSection extends StatelessWidget {
  const TrackItemCardSection({super.key, required this.controller});

  final TrackerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemTrackerWidget(
          onTap: () {
            controller.toggleExpanded();
          },
        ),
        Obx(
          () =>
              controller.isExpanded.value
                  ? AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        AppDivider(),
                        Row(
                          children: [
                            Expanded(child: IconTextColumn()),
                            Gap(width: AppSize.width(value: 8)),
                            Expanded(
                              child: IconTextColumn(
                                onTap: () {
                                  Get.toNamed(AppRoutes.instance.findNearby);
                                },
                                text: "Find Nearby",
                                iconPath: AssetsIconsPath.instance.arrowGreen,
                              ),
                            ),
                          ],
                        ),
                        Gap(height: AppSize.width(value: 8)),
                        Row(
                          children: [
                            Expanded(
                              child: IconTextColumn(
                                onTap: () {
                                  Get.toNamed(AppRoutes.instance.shareItem);
                                },
                                text: "Share Item",
                                iconPath: AssetsIconsPath.instance.addUser,
                              ),
                            ),
                            Gap(width: AppSize.width(value: 8)),
                            Expanded(
                              child: IconTextColumn(
                                onTap: () {
                                  Get.bottomSheet(
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: AppSize.width(value: 36),
                                        left: AppSize.width(value: 20),
                                        right: AppSize.width(value: 20),
                                        bottom: AppSize.width(
                                          value: 100,
                                        ), // Add bottom padding for spacing
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.instance.white200,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      ),
                                      // ✅ Remove width or use full screen width
                                      width: double.infinity,

                                      // ✅ Wrap Column with IntrinsicHeight or not needed if Column fits naturally
                                      child: Column(
                                        mainAxisSize:
                                            MainAxisSize
                                                .min, // ✅ Makes the height dynamic!
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            data: "Are you sure ?",
                                            fontSize: AppSize.width(value: 20),
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.instance.black900,
                                          ),
                                          Gap(height: AppSize.width(value: 20)),
                                          AppText(
                                            data:
                                                "Do you want to turn on tracking notification option",
                                            fontSize: AppSize.width(value: 12),
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.instance.black300,
                                          ),
                                          Gap(height: AppSize.width(value: 16)),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: AppButton(
                                                  title: "No",
                                                  height: AppSize.width(
                                                    value: 38,
                                                  ),
                                                ),
                                              ),
                                              Gap(
                                                width: AppSize.width(value: 20),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    // Add your logic here
                                                  },
                                                  style: OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                      color:
                                                          AppColors
                                                              .instance
                                                              .purple_500,
                                                    ),
                                                    foregroundColor:
                                                        AppColors
                                                            .instance
                                                            .purple_500,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: AppText(
                                                    data: "Yes",
                                                    fontSize: AppSize.width(
                                                      value: 16,
                                                    ),
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors
                                                            .instance
                                                            .purple_500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                text: "Notification",
                                iconPath: AssetsIconsPath.instance.bellRed,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  : SizedBox.shrink(),
        ),
      ],
    );
  }
}
