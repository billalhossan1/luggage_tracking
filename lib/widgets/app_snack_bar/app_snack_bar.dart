
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class AppSnackBar {
  // >>>>>>>>>>>>>>>>>>>>>> when show message  <<<<<<<<<<<<<<<<<<<<<<

  // >>>>>>>>>>>>>>>>>>>>>> error message snackbar  <<<<<<<<<<<<<<<<<<<<<<
  static error(String parameterValue) {
    Get.showSnackbar(
      GetSnackBar(

        backgroundColor: AppColors.instance.red2,
        animationDuration: const Duration(seconds: 2),
        duration: const Duration(seconds: 3),
        messageText: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: "Error!",
              color: AppColors.instance.black500,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
            AppText(
              data: parameterValue,
              color: AppColors.instance.white50,
            ),
          ],
        ),
      ),
    );
  }

  // >>>>>>>>>>>>>>>>>>>>>> success message <<<<<<<<<<<<<<<<<<<<<<

  static success(String parameterValue) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.instance.black500,
        animationDuration: const Duration(seconds: 2),
        duration: const Duration(seconds: 2),
        messageText: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: "Success!",
              color: AppColors.instance.white50,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
            AppText(
              data: parameterValue,
              color: AppColors.instance.white50,
            ),
          ],
        ),
      ),
    );
  }

  // >>>>>>>>>>>>>>>>>>>>>> message  <<<<<<<<<<<<<<<<<<<<<<
  // >>>>>>>>>>>>>>>>>>>>>> only show message <<<<<<<<<<<<<<<<<<<<<<

  static message(String parameterValue) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.instance.purple_100,
        animationDuration: const Duration(seconds: 2),
        duration: const Duration(seconds: 3),
        messageText: AppText(
          data: parameterValue,
          color: AppColors.instance.white500,
          fontSize: 16,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
        ),
        borderRadius: AppSize.width(value: 20.0),
        padding: EdgeInsets.all(AppSize.width(value: 10.0)),
        margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 40.0), vertical: AppSize.width(value: 30)),
      ),
    );
  }
}
