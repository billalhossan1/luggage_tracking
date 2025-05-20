import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';

class SplashScreenController extends GetxController {

  // GetStorageServices storageServices = GetStorageServices.instance;
  RxDouble animation = 0.0.obs;
  RxDouble animation2 = 0.0.obs;

  Future<void> onInitialDataLoadScreen() async {
    try {
      Future.delayed(Durations.medium1, () {
        animation.value = 1.0;
        animation2.value = 1.0;
         
      });

      
      Future.delayed(Duration(seconds: 3), () {
        // Get.delete<SplashScreenController>();
        // if (value) {
          // Get.offAllNamed(AppRoutes.instance.onBoardingScreen);
        // } else {
        //   Get.offAllNamed(AppRoutes.instance.wellCome);
        // }
      });
    } catch (e) {
      errorLog("onInitialDataLoadScreen", e);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Get.offAllNamed(AppRoutes.instance.errorScreen);
      });
    }
  }

  @override
  void onInit() {
    onInitialDataLoadScreen();
    super.onInit();
  }
}
