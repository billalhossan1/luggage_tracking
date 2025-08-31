import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/permission_dialog.dart';

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
      bool? isPermit = await showPermissionDialog(
        context: Get.context!,
        title: 'Permission Required for tracking your device',
        content: 'Location permission is required to proceed. Would you like to give permission?',
        denyText: 'No',
        allowText: 'Yes',
      );
      if (isPermit == true) {
        currentPosition.value = await _getCurrentLocationOnce();
        if (currentPosition.value != null) {
          isCurrentLocation.value = true;
        }
      }
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
    // Ask for location permission using the reusable dialog
    bool? isPermit = await showPermissionDialog(
      context: Get.context!,
      title: 'Permission Required for tracking your device',
      content: 'Location permission is required to proceed. Would you like to give permission?',
      denyText: 'No',
      allowText: 'Yes',
    );
    if (isPermit == null || isPermit == false) {
      return null;
    }

    final isGranted = await _isLocationPermissionGranted();

    if (!isGranted) {
      final granted = await _requestPermission();
      if (!granted) {
        bool? openSettings = await showPermissionDialog(
          context: Get.context!,
          title: 'Permission Required for tracking your device',
          content: 'Location permission is required to proceed. Would you like to open the settings to enable it?',
          denyText: 'No',
          allowText: 'Yes',
        );
        if (openSettings == true) {
          await Geolocator.openAppSettings();
        }
        return null;
      }
    }

    // Check if GPS service is enabled
    final isServiceEnabled = await _checkGpsServiceEnable();
    if (!isServiceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    try {
      // Try fetching the current position with high accuracy
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      showCustomSnackBar(
        title: 'Error',
        message: 'Failed to get location: $e',
        isError: true,
      );
      return null;
    }
  }

  Future<bool> _isLocationPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _checkGpsServiceEnable() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    return isServiceEnabled;
  }

  void goToCurrentLocation(GoogleMapController mapController) {
    if (currentPosition.value != null) {
      final cameraUpdate = CameraUpdate.newLatLngZoom(currentPosition.value!, 16);
      mapController.animateCamera(cameraUpdate);
    }
  }
}
