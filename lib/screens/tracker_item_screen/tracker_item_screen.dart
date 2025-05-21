import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/controller/tracker_controller.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/widgets/icon_text_column.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/widgets/item_tracker_widget.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
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
  const TrackItemCardSection({
    super.key,
    required this.controller,
  });

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
  }
}

