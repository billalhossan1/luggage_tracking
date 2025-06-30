import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

import '../../../widgets/snackbar_message/snackBar_widget.dart';

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
    print("isSubscribed: $isSubscribed");
  }


  @override
  Future<void> onInit() async {
    super.onInit();
    currentPosition.value = await _getCurrentLocationOnce();
    if (currentPosition.value != null) {
      isCurrentLocation.value = true;
      print("===============================${currentPosition.value}");
    } else {
      print("Failed to get location");
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
      final granted = await _requestPermission();
      if (!granted) {
        await Geolocator.openAppSettings();
        return null;
      }
    }

    final isServiceEnabled = await _checkGpsServiceEnable();
    if (!isServiceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      print("Location: ${position.latitude}, ${position.longitude}");
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      showCustomSnackBar(
        title: 'Error',
        message: 'Failed to get location: $e',
        isError: true,
      );
      print("Error getting location: $e");
      return null;
    }
  }

  Future<bool> _isLocationPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    print("Permission status: $permission");
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print("Requested Permission: $permission");
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _checkGpsServiceEnable() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print("GPS Service Enabled: $isServiceEnabled");
    return isServiceEnabled;
  }

  void goToCurrentLocation(GoogleMapController mapController) {
    if (currentPosition.value != null) {
      final cameraUpdate = CameraUpdate.newLatLngZoom(currentPosition.value!, 16);
      mapController.animateCamera(cameraUpdate);
    }
  }
}

