import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class OtpVerificationScreenController extends GetxController {
  RxString argMail = "".obs;
  RxBool isEmailVerification = false.obs;
  RxBool hasError = false.obs;
  RxBool otpIsLoading = false.obs;
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? errorMessage;
  String? message;
  String name = '';

  GlobalKey<FormState> verificationCodeKey = GlobalKey<FormState>();

  final RxInt _seconds = 0.obs;
  RxInt get seconds => _seconds;
  Timer? _timer;
  TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    setArgData();
  }

  void setArgData() {
    try {
      var argData = Get.arguments;
      if (argData != null && argData is Map) {
        argMail.value = (argData["email"] ?? "").toString().toLowerCase();
        name = argData['name'] ?? '';
        isEmailVerification.value = argData["isEmailVerification"] ?? false;
      }
      startTimer();
    } catch (e) {
      log("error form otp verification arg set data function : $e");
    }
  }

  Future<dynamic> otpVerification() async {
    Map<String, dynamic> body = {
      "email": argMail.value,
      "oneTimeCode": otpController.text,
    };
    // print("email:${email.value}");
    otpIsLoading.value = true;
    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(Urls.verifyEmailUrl, body: body);
    otpIsLoading.value = false;
    return response;
    // Simulate network response or connect to AuthRepository
    // return await authRepository.verifyEmail(email: argMail.value, otp: otpController.text.trim());
  }

  Future<dynamic> resendOtp() async {
    Map<String, dynamic> body = {
      "email": argMail.value,
    };
    // print("email:${email.value}");
    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(Urls.resendOtpUrl, body: body);

    return response;
    // Simulate network response or connect to AuthRepository
    // return await authRepository.verifyEmail(email: argMail.value, otp: otpController.text.trim());
  }

  Future<void> onTapResend() async {
    try {
      if (argMail.value.isNotEmpty) {
        startTimer();
        _inProgress = true;
        var response = await resendOtp();
        _inProgress = false;
        if (response != null) {
          if (response.isSuccess) {
            errorMessage = null;
            message = response.responseData["message"];
            AppSnackBar.success(message!);
          } else {
            errorMessage = response.errorMessage;
            hasError.value = true;
            AppSnackBar.error(errorMessage!);
          }
        }
      } else {
        AppSnackBar.error("Back to Previous Page and Enter your Email again");
      }
    } catch (e) {
      log("error from click resend button : $e");
      _inProgress = false;
    }
  }

  Future<void> clickVerificationCodeButton() async {
    try {
      if (verificationCodeKey.currentState!.validate()) {
        _inProgress = true;
        var response = await otpVerification();
        _inProgress = false;
        if (response != null) {
          if (isEmailVerification.value) {
            if (response.isSuccess) {
              errorMessage = null;
              message = response.responseData["message"];
              AppSnackBar.success(message!);
              String token = response.responseData["data"]["accessToken"];
              // Get.toNamed(AppRoutes.instance.signUpWithPersonalData,arguments: {"token":'', "email": argMail.value,"name":''});
              await Get.find<SaveDataController>().setUserEmail(argMail.value);
              Get.offAllNamed(AppRoutes.instance.subPlanScreen, arguments: {"email": argMail.value, "name": name, "token": token});
            } else {
              errorMessage = response.errorMessage;
              hasError.value = true;
              AppSnackBar.error(errorMessage!);
            }
            // Get.back(times: 2);
          } else {
            if (response.isSuccess) {
              var verifyToken = response.responseData["data"];
              errorMessage = null;
              message = response.responseData["message"];
              AppSnackBar.success(message!);
              Get.offNamed(AppRoutes.instance.cretaeNewPasswordScreen, arguments: {"verifyToken": verifyToken.toString()});
            } else {
              errorMessage = response.errorMessage;
              hasError.value = true;
              AppSnackBar.error(errorMessage!);
            }
          }
        }
        _inProgress = false;
      }
    } catch (e) {
      log("error from click verification code function button : $e");
      _inProgress = false;
    }
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return minutes > 0 ? '$minutes:${remainingSeconds.toString().padLeft(2, '0')}' : '$remainingSeconds';
  }

  void startTimer() async {
    try {
      _seconds.value = 180;
      _timer?.cancel();
      _timer = null;
      _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          _seconds.value = _seconds.value - 1;
          if (_seconds.value <= 0) {
            timer.cancel();
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void stopTimer() {
    try {
      _timer?.cancel();
      _timer = null;
    } catch (e) {
      log(e.toString());
    }
    _seconds.value = 0;
  }

  void appClose() {
    try {
      otpController.dispose();
      stopTimer();
    } catch (e) {
      errorLog("app close", e);
    }
  }

  @override
  void onClose() {
    appClose();
    super.onClose();
  }
}
