import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/permission_dialog.dart';

import '../../../utils/location_utils.dart';
import '../../../widgets/snackbar_message/snack_bar_widget.dart';

class TrackerController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool isActiveSound = false.obs;
  var currentPosition = Rx<LatLng?>(null);
  final initialCameraPosition = LatLng(54.613072699163325, 15.22438119481026);
  RxBool isCurrentLocation = false.obs;
  bool isSubscribed = false;

  Future<void> isSubscribe() async {
    final bool isSubscribe = await SaveDataController().getIsSubscribe();
    isSubscribed = isSubscribe;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // bool? isPermit = await showPermissionDialog(
      //   context: Get.context!,
      //   title: 'Permission Required for tracking your device',
      //   content: 'Location permission is required to proceed. Would you like to give permission?',
      //   allowText: 'Continue',
      // );
      // if (isPermit == true) {
        currentPosition.value = await _getCurrentLocationOnce();
        // if (currentPosition.value != null) {
        //   isCurrentLocation.value = true;
        // }
      // }
    });
    await isSubscribe();
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void soundActive() {
    isActiveSound.value = !isActiveSound.value;
  }

  Future<LatLng?> _getCurrentLocationOnce() async {
    // Use centralized permission and location logic
    final position = await appUserGeoLocation();
    if (position == null) {
      showCustomSnackBar(
        title: 'Error',
        message: 'Failed to get location or permission denied.',
        isError: true,
      );
      return null;
    }
    return LatLng(position.latitude, position.longitude);
  }

  void goToCurrentLocation(GoogleMapController mapController) {
    if (currentPosition.value != null) {
      final cameraUpdate = CameraUpdate.newLatLngZoom(currentPosition.value!, 16);
      mapController.animateCamera(cameraUpdate);
    }
  }
}
