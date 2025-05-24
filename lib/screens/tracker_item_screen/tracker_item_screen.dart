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
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
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
      appBar: CustomAppBar(
        title: "Track Item",
        showLeading: false,
        autoShowLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          Get.bottomSheet(
            FractionallySizedBox(
              heightFactor: 0.45, // Use up to 90% of the screen height
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
                      Gap(height: AppSize.width(value: 16)),
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
                        children: List.generate(1, (index) {
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
                                                    child: StartSoundActiveButton(
                                                      onTap:
                                                          () =>
                                                              controller
                                                                  .soundActive(),
                                                      controller: controller,
                                                    ),
                                                  ),
                                                  Gap(
                                                    width: AppSize.width(
                                                      value: 8,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: IconTextColumn(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          AppRoutes
                                                              .instance
                                                              .findNearby,
                                                        );
                                                      },
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
                                                      onTap: () {
                                                        Get.toNamed(
                                                          AppRoutes
                                                              .instance
                                                              .shareItem,
                                                        );
                                                      },
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
                                                      onTap: () {
                                                        Get.bottomSheet(
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                              top:
                                                                  AppSize.width(
                                                                    value: 36,
                                                                  ),
                                                              left:
                                                                  AppSize.width(
                                                                    value: 20,
                                                                  ),
                                                              right:
                                                                  AppSize.width(
                                                                    value: 20,
                                                                  ),
                                                              bottom: AppSize.width(
                                                                value: 100,
                                                              ), // Add bottom padding for spacing
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  AppColors
                                                                      .instance
                                                                      .white200,
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          12,
                                                                        ),
                                                                    topRight:
                                                                        Radius.circular(
                                                                          12,
                                                                        ),
                                                                  ),
                                                            ),
                                                            // ✅ Remove width or use full screen width
                                                            width:
                                                                double.infinity,

                                                            // ✅ Wrap Column with IntrinsicHeight or not needed if Column fits naturally
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min, // ✅ Makes the height dynamic!
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AppText(
                                                                  data:
                                                                      "Are you sure ?",
                                                                  fontSize:
                                                                      AppSize.width(
                                                                        value:
                                                                            20,
                                                                      ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      AppColors
                                                                          .instance
                                                                          .black900,
                                                                ),
                                                                Gap(
                                                                  height:
                                                                      AppSize.width(
                                                                        value:
                                                                            20,
                                                                      ),
                                                                ),
                                                                AppText(
                                                                  data:
                                                                      "Do you want to turn on tracking notification option",
                                                                  fontSize:
                                                                      AppSize.width(
                                                                        value:
                                                                            12,
                                                                      ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      AppColors
                                                                          .instance
                                                                          .black300,
                                                                ),
                                                                Gap(
                                                                  height:
                                                                      AppSize.width(
                                                                        value:
                                                                            16,
                                                                      ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          SizedBox(),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: AppButton(
                                                                        title:
                                                                            "No",
                                                                        height: AppSize.width(
                                                                          value:
                                                                              38,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Gap(
                                                                      width: AppSize.width(
                                                                        value:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: OutlinedButton(
                                                                        onPressed:
                                                                            () {
                                                                              // Add your logic here
                                                                            },
                                                                        style: OutlinedButton.styleFrom(
                                                                          side: BorderSide(
                                                                            color:
                                                                                AppColors.instance.purple_500,
                                                                          ),
                                                                          foregroundColor:
                                                                              AppColors.instance.purple_500,
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                              8,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child: AppText(
                                                                          data:
                                                                              "Yes",
                                                                          fontSize: AppSize.width(
                                                                            value:
                                                                                16,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color:
                                                                              AppColors.instance.purple_500,
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
                      Gap(height: AppSize.width(value: 16)),
                      AppText(
                        data: "Others Items",
                        fontSize: AppSize.width(value: 14),
                        fontWeight: FontWeight.w400,
                        color: AppColors.instance.black200,
                      ),
                      Gap(height: AppSize.width(value: 16)),
                      Column(
                        children: List.generate(1, (index) {
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
                                                    child: StartSoundActiveButton(
                                                      onTap:
                                                          () =>
                                                              controller
                                                                  .soundActive(),
                                                      controller: controller,
                                                    ),
                                                  ),
                                                  Gap(
                                                    width: AppSize.width(
                                                      value: 8,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: IconTextColumn(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          AppRoutes
                                                              .instance
                                                              .findNearby,
                                                        );
                                                      },
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
                                                      onTap: () {
                                                        Get.toNamed(
                                                          AppRoutes
                                                              .instance
                                                              .shareItem,
                                                        );
                                                      },
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
                                                      onTap: () {
                                                        Get.bottomSheet(
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                              top:
                                                                  AppSize.width(
                                                                    value: 36,
                                                                  ),
                                                              left:
                                                                  AppSize.width(
                                                                    value: 20,
                                                                  ),
                                                              right:
                                                                  AppSize.width(
                                                                    value: 20,
                                                                  ),
                                                              bottom: AppSize.width(
                                                                value: 100,
                                                              ), // Add bottom padding for spacing
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  AppColors
                                                                      .instance
                                                                      .white200,
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          12,
                                                                        ),
                                                                    topRight:
                                                                        Radius.circular(
                                                                          12,
                                                                        ),
                                                                  ),
                                                            ),
                                                            // ✅ Remove width or use full screen width
                                                            width:
                                                                double.infinity,

                                                            // ✅ Wrap Column with IntrinsicHeight or not needed if Column fits naturally
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min, // ✅ Makes the height dynamic!
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AppText(
                                                                  data:
                                                                      "Are you sure ?",
                                                                  fontSize:
                                                                      AppSize.width(
                                                                        value:
                                                                            20,
                                                                      ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      AppColors
                                                                          .instance
                                                                          .black900,
                                                                ),
                                                                Gap(
                                                                  height:
                                                                      AppSize.width(
                                                                        value:
                                                                            20,
                                                                      ),
                                                                ),
                                                                AppText(
                                                                  data:
                                                                      "Do you want to turn on tracking notification option",
                                                                  fontSize:
                                                                      AppSize.width(
                                                                        value:
                                                                            12,
                                                                      ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      AppColors
                                                                          .instance
                                                                          .black300,
                                                                ),
                                                                Gap(
                                                                  height:
                                                                      AppSize.width(
                                                                        value:
                                                                            16,
                                                                      ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          SizedBox(),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: AppButton(
                                                                        title:
                                                                            "No",
                                                                        height: AppSize.width(
                                                                          value:
                                                                              38,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Gap(
                                                                      width: AppSize.width(
                                                                        value:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: OutlinedButton(
                                                                        onPressed:
                                                                            () {
                                                                              // Add your logic here
                                                                            },
                                                                        style: OutlinedButton.styleFrom(
                                                                          side: BorderSide(
                                                                            color:
                                                                                AppColors.instance.purple_500,
                                                                          ),
                                                                          foregroundColor:
                                                                              AppColors.instance.purple_500,
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                              8,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child: AppText(
                                                                          data:
                                                                              "Yes",
                                                                          fontSize: AppSize.width(
                                                                            value:
                                                                                16,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color:
                                                                              AppColors.instance.purple_500,
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

class StartSoundActiveButton extends StatelessWidget {
  final TrackerController controller;
  final VoidCallback? onTap;
  const StartSoundActiveButton({
    super.key,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        // ✅ Add Obx here to listen to observable changes
        () => Container(
          padding: EdgeInsets.symmetric(
            vertical: AppSize.width(value: 26),
            horizontal: AppSize.width(value: 16),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:
                controller.isActiveSound.value
                    ? AppColors.instance.purple_500
                    : AppColors.instance.white200,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                offset: Offset(-4, 4),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImage(
                path:
                    controller.isActiveSound.value
                        ? AssetsIconsPath
                            .instance
                            .soundActive // ✅ Use different icons for active/inactive
                        : AssetsIconsPath.instance.soundInActive,
                width: AppSize.width(value: 20),
                height: AppSize.width(value: 20),
              ),
              Gap(height: AppSize.width(value: 8)),
              AppText(
                data: "Start Sound",
                fontSize: AppSize.width(value: 14),
                fontWeight: FontWeight.w500,
                color:
                    controller.isActiveSound.value
                        ? AppColors.instance.white500
                        : AppColors.instance.black700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class StartSoundActiveButton extends StatelessWidget {
//   final TrackerController controller;
//   final VoidCallback? onTap;
//   const StartSoundActiveButton({
//     super.key,
//     required this.controller,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           vertical: AppSize.width(value: 26),
//           horizontal: AppSize.width(value: 16),
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color:
//               controller.isActiveSound.value
//                   ? AppColors.instance.blue1
//                   : AppColors.instance.white50,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: .1), // Shadow color
//               offset: Offset(-4, 4), // x: left (-), y: bottom (+)
//               blurRadius: 6,
//               spreadRadius: 1,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppImage(
//               path:
//                   controller.isActiveSound.value
//                       ? AssetsIconsPath.instance.soundInActive
//                       : AssetsIconsPath.instance.soundInActive,
//               width: AppSize.width(value: 20),
//               height: AppSize.width(value: 20),
//             ),
//             Gap(height: AppSize.width(value: 8)),
//             AppText(
//               data: "Start Sound",
//               fontSize: AppSize.width(value: 14),
//               fontWeight: FontWeight.w500,
//               color:
//                   controller.isActiveSound.value
//                       ? AppColors.instance.white500
//                       : AppColors.instance.black700,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
