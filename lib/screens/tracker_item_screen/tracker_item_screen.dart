import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/controller/tracker_controller.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/widgets/icon_text_column.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/widgets/item_tracker_widget.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/divider/app_divider.dart';
import 'package:luggage_tracking/widgets/snackbar_message/snack_bar_widget.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class TrackerItemScreen extends StatefulWidget {
  const TrackerItemScreen({super.key});

  @override
  State<TrackerItemScreen> createState() => _TrackerItemScreenState();
}

class _TrackerItemScreenState extends State<TrackerItemScreen> {
  late GoogleMapController _mapController;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackerController>(
      init: TrackerController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tracker Item"),
          ),
          body: Stack(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final currentPos = controller.currentPosition.value ?? controller.initialCameraPosition;

                return GoogleMap(
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: currentPos,
                    zoom: controller.isCurrentLocation.value ? 15 : 9,
                  ),
                  onMapCreated: (mapCtrl) {
                    _mapController = mapCtrl;
                  },
                  circles: controller.isCurrentLocation.value
                      ? {
                          Circle(
                            circleId: const CircleId('current_location_circle'),
                            center: currentPos,
                            radius: 100,
                            fillColor: Colors.blue.withAlpha(60),
                            strokeColor: Colors.blue,
                            strokeWidth: 2,
                          ),
                        }
                      : {},
                );
              }),
            ],
          ),
          // Floating Action Button to navigate to the current location
          floatingActionButton: FloatingActionButton(
            onPressed: () {
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
                                    () => controller.isExpanded.value
                                        ? AnimatedContainer(
                                            duration: Duration(milliseconds: 300),
                                            child: Column(
                                              children: [
                                                AppDivider(),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: StartSoundActiveButton(
                                                        onTap: () {
                                                          if (controller.isSubscribed) {
                                                            controller.soundActive();
                                                          } else {
                                                            showCustomSnackBar(
                                                                title: "Failed",
                                                                message: "you need to purchase premium subscription for access these function",
                                                                isError: true);
                                                          }
                                                        },
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
                                                          if (controller.isSubscribed) {
                                                            Get.toNamed(
                                                              AppRoutes.instance.findNearby,
                                                            );
                                                          } else {
                                                            showCustomSnackBar(
                                                                title: "Failed",
                                                                message: "you need to purchase premium subscription for access these function",
                                                                isError: true);
                                                          }
                                                        },
                                                        text: "Find Nearby",
                                                        iconPath: AssetsIconsPath.instance.arrowGreen,
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
                                                          if (controller.isSubscribed) {
                                                            Get.toNamed(
                                                              AppRoutes.instance.shareItem,
                                                            );
                                                          } else {
                                                            showCustomSnackBar(
                                                                title: "Failed",
                                                                message: "you need to purchase premium subscription for access these function",
                                                                isError: true);
                                                          }
                                                        },
                                                        text: "Share Item",
                                                        iconPath: AssetsIconsPath.instance.addUser,
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
                                                                top: AppSize.width(
                                                                  value: 36,
                                                                ),
                                                                left: AppSize.width(
                                                                  value: 20,
                                                                ),
                                                                right: AppSize.width(
                                                                  value: 20,
                                                                ),
                                                                bottom: AppSize.width(
                                                                  value: 100,
                                                                ), // Add bottom padding for spacing
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: AppColors.instance.white200,
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(
                                                                    12,
                                                                  ),
                                                                  topRight: Radius.circular(
                                                                    12,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: double.infinity,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min, // ✅ Makes the height dynamic!
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  AppText(
                                                                    data: "Are you sure ?",
                                                                    fontSize: AppSize.width(
                                                                      value: 20,
                                                                    ),
                                                                    fontWeight: FontWeight.w400,
                                                                    color: AppColors.instance.black900,
                                                                  ),
                                                                  Gap(
                                                                    height: AppSize.width(
                                                                      value: 20,
                                                                    ),
                                                                  ),
                                                                  AppText(
                                                                    data: "Do you want to turn on tracking notification option",
                                                                    fontSize: AppSize.width(
                                                                      value: 12,
                                                                    ),
                                                                    fontWeight: FontWeight.w500,
                                                                    color: AppColors.instance.black300,
                                                                  ),
                                                                  Gap(
                                                                    height: AppSize.width(
                                                                      value: 16,
                                                                    ),
                                                                  ),
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
                                                                        width: AppSize.width(
                                                                          value: 20,
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child: OutlinedButton(
                                                                          onPressed: () {
                                                                            // Add your logic here
                                                                          },
                                                                          style: OutlinedButton.styleFrom(
                                                                            side: BorderSide(
                                                                              color: AppColors.instance.purple_500,
                                                                            ),
                                                                            foregroundColor: AppColors.instance.purple_500,
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
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
                                                                            color: AppColors.instance.purple_500,
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
                                    () => controller.isExpanded.value
                                        ? AnimatedContainer(
                                            duration: Duration(milliseconds: 300),
                                            child: Column(
                                              children: [
                                                AppDivider(),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: StartSoundActiveButton(
                                                        onTap: () {
                                                          if (controller.isSubscribed) {
                                                            controller.soundActive();
                                                          } else {
                                                            showCustomSnackBar(
                                                                title: "Failed",
                                                                message: "you need to purchase premium subscription for access these function",
                                                                isError: true);
                                                          }
                                                        },
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
                                                          if (controller.isSubscribed) {
                                                            // Get.toNamed(
                                                            //   AppRoutes
                                                            //       .instance
                                                            //       .findNearby,
                                                            // );
                                                          } else {
                                                            showCustomSnackBar(
                                                                title: "Failed",
                                                                message: "you need to purchase premium subscription for access these function",
                                                                isError: true);
                                                          }
                                                        },
                                                        text: "Find Nearby",
                                                        iconPath: AssetsIconsPath.instance.arrowGreen,
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
                                                          if (controller.isSubscribed) {
                                                            Get.toNamed(
                                                              AppRoutes.instance.shareItem,
                                                            );
                                                          } else {
                                                            showCustomSnackBar(
                                                                title: "Failed",
                                                                message: "you need to purchase premium subscription for access these function",
                                                                isError: true);
                                                          }
                                                        },
                                                        text: "Share Item",
                                                        iconPath: AssetsIconsPath.instance.addUser,
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
                                                                top: AppSize.width(
                                                                  value: 36,
                                                                ),
                                                                left: AppSize.width(
                                                                  value: 20,
                                                                ),
                                                                right: AppSize.width(
                                                                  value: 20,
                                                                ),
                                                                bottom: AppSize.width(
                                                                  value: 100,
                                                                ), // Add bottom padding for spacing
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: AppColors.instance.white200,
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(
                                                                    12,
                                                                  ),
                                                                  topRight: Radius.circular(
                                                                    12,
                                                                  ),
                                                                ),
                                                              ),
                                                              // ✅ Remove width or use full screen width
                                                              width: double.infinity,

                                                              // ✅ Wrap Column with IntrinsicHeight or not needed if Column fits naturally
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min, // ✅ Makes the height dynamic!
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  AppText(
                                                                    data: "Are you sure ?",
                                                                    fontSize: AppSize.width(
                                                                      value: 20,
                                                                    ),
                                                                    fontWeight: FontWeight.w400,
                                                                    color: AppColors.instance.black900,
                                                                  ),
                                                                  Gap(
                                                                    height: AppSize.width(
                                                                      value: 20,
                                                                    ),
                                                                  ),
                                                                  AppText(
                                                                    data: "Do you want to turn on tracking notification option",
                                                                    fontSize: AppSize.width(
                                                                      value: 12,
                                                                    ),
                                                                    fontWeight: FontWeight.w500,
                                                                    color: AppColors.instance.black300,
                                                                  ),
                                                                  Gap(
                                                                    height: AppSize.width(
                                                                      value: 16,
                                                                    ),
                                                                  ),
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
                                                                        width: AppSize.width(
                                                                          value: 20,
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child: OutlinedButton(
                                                                          onPressed: () {
                                                                            // Add your logic here
                                                                          },
                                                                          style: OutlinedButton.styleFrom(
                                                                            side: BorderSide(
                                                                              color: AppColors.instance.purple_500,
                                                                            ),
                                                                            foregroundColor: AppColors.instance.purple_500,
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
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
                                                                            color: AppColors.instance.purple_500,
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
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                isScrollControlled: true,
              );
            }, // Icon for location
            backgroundColor: Colors.blue, // Trigger action
            child: const Icon(Icons.my_location), // FAB background color
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        );
      },
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
            color: controller.isActiveSound.value ? AppColors.instance.purple_500 : AppColors.instance.white200,
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
                path: controller.isActiveSound.value
                    ? AssetsIconsPath.instance.soundActive // ✅ Use different icons for active/inactive
                    : AssetsIconsPath.instance.soundInActive,
                width: AppSize.width(value: 20),
                height: AppSize.width(value: 20),
              ),
              Gap(height: AppSize.width(value: 8)),
              AppText(
                data: "Start Sound",
                fontSize: AppSize.width(value: 14),
                fontWeight: FontWeight.w500,
                color: controller.isActiveSound.value ? AppColors.instance.white500 : AppColors.instance.black700,
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
