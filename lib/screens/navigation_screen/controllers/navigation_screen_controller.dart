import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';
import 'package:luggage_tracking/utils/location_utils.dart';

import '../../../services/save_data/save_data.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

/////////  variable
Rxn<Position> appGlobalLocationData = Rxn();

class NavigationScreenController extends GetxController {
  RxInt selectedIndex = RxInt(0);

  bool isLoading = true;
  bool isExpanded = false;

  void toggleExpansion() {
    isExpanded = !isExpanded;
    update();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  bool isSubscribe = false;
  @override
  void onInit() {
    initial();
    super.onInit();
  }

  Future<void> initial() async {
    try {
      isLoading = true;
      if (!Get.isRegistered<SaveDataController>()) {
        Get.lazyPut(() => SaveDataController());
      }
      isSubscribe = await SaveDataController().getIsSubscribe();
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever|| permission == LocationPermission.denied) {
        await _showLocationPermissionDialog();
        isLoading = false;
        update();
        return;
      }
      appGlobalLocationData.value = await appUserGeoLocation();
      if (appGlobalLocationData.value == null) {
        await _showLocationPermissionDialog();
      }
    } catch (e) {
      errorLog("initial", e);
    }
    isLoading = false;
    update();
  }

  Future<void> _showLocationPermissionDialog() async {
    await Get.defaultDialog(
      title: 'Location Permission Required',
      content: const Text(
        'This app needs location permission to track your device. Please enable location access in your device settings.',
        textAlign: TextAlign.center,
      ),
      radius: 8,
      confirm: ElevatedButton(
        onPressed: () async {
          await Geolocator.openAppSettings();
          Get.back();
        },
        child: const Text('Open Settings'),
      ),
      cancel:  ElevatedButton(
        onPressed: () async {
          Get.back();
        },
        child: const Text('Cancel'),
      ),
    );
  }

  // @override
  // void onClose() {
  //   appUserData.dispose();
  //   super.onClose();
  // }
}
