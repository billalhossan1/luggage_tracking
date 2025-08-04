import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

import '../../../widgets/snackbar_message/snack_bar_widget.dart';

class TrackerController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool isActiveSound = false.obs;
  var currentPosition = Rx<LatLng?>(null);
  final initialCameraPosition = LatLng(54.613072699163325, 15.22438119481026);
  RxBool isCurrentLocation = false.obs;
  bool isSubscribed = false;



  Future<void> isSubscribe()async{
    final bool isSubscribe = await SaveDataController().getIsSubscribe();
    isSubscribed = isSubscribe;
  }


  @override
  Future<void> onInit() async {
    super.onInit();
    currentPosition.value = await _getCurrentLocationOnce();
    if (currentPosition.value != null) {
      isCurrentLocation.value = true;
    } else {
    }
    await isSubscribe();
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void soundActive() {
    isActiveSound.value = !isActiveSound.value;
  }

  Future<LatLng?> _getCurrentLocationOnce() async {
    final isGranted = await _isLocationPermissionGranted();

    if (!isGranted) {
      // If not granted, ask for permission and show dialog
      final granted = await _requestPermission();
      if (!granted) {
        // Show an alert dialog asking the user if they want to open settings
        bool? openSettings = await showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Required for tracking your device'),
              content: Text(
                  'Location permission is required to proceed. Would you like to open the settings to enable it?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
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

