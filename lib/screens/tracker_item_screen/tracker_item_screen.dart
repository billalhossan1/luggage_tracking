import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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


  void _goToCurrentLocation() {
    final controller = Get.find<TrackerController>();
    controller.goToCurrentLocation(_mapController);
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
                final currentPos = controller.currentPosition.value ??
                    controller.initialCameraPosition;

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
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _goToCurrentLocation, // Trigger action
          //   child: const Icon(Icons.my_location), // Icon for location
          //   backgroundColor: Colors.blue, // FAB background color
          // ),
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
