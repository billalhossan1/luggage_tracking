import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
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

  GlobalKey<FormState> verificationCodeKey = GlobalKey<FormState>();

  final RxInt _seconds = 0.obs;
  RxInt get seconds => _seconds;
  late Isolate _isolate;

  TextEditingController otpController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    setArgData();
  }

  setArgData() {
    try {
      var argData = Get.arguments;
      if (argData != null && argData is Map) {
        argMail.value = argData["email"] ?? "";
        isEmailVerification.value = argData["isEmailVerification"] ?? false;
       // var logger= Logger();
       // logger.i("argMail:${argMail.value}");
       // logger.i("isEmailVerification:${isEmailVerification.value}");
      }
      startTimer();
    } catch (e) {
      log("error form otp verification arg set data function : $e");
    }
  }

  Future<dynamic> otpVerification() async {
    Map<String, dynamic> body = {"email":argMail.value,"oneTimeCode": otpController.text,};
    // print("email:${email.value}");
    otpIsLoading.value =true;
    final NetworkResponse response =
    await Get.find<NetworkCaller>().postRequest(Urls.verifyEmailUrl, body: body);
    otpIsLoading.value = false;
    return response;
    // Simulate network response or connect to AuthRepository
    // return await authRepository.verifyEmail(email: argMail.value, otp: otpController.text.trim());
  }

  Future<dynamic>resendOtp()async{
    Map<String, dynamic> body = {"email":argMail.value,};
    // print("email:${email.value}");
    final NetworkResponse response =
    await Get.find<NetworkCaller>().postRequest(Urls.resendOtpUrl, body: body);

    return response;
    // Simulate network response or connect to AuthRepository
    // return await authRepository.verifyEmail(email: argMail.value, otp: otpController.text.trim());


  }

  Future<void> onTapResend()async{

    try {
      if (argMail.value.isNotEmpty) {
        _inProgress = true;
        var response = await resendOtp();
        _inProgress = false;
        if (response != null) {
          if (response.isSuccess) {
            errorMessage = null;
            message = response.responseData["message"];
            AppSnackBar.success(message!);
            startTimer();
          } else {
            errorMessage = response.errorMessage;
            hasError.value = true;
            AppSnackBar.error(errorMessage!);
          }
        }
      } else {
        AppSnackBar.error("Email is empty");
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
              // Get.toNamed(AppRoutes.instance.signUpWithPersonalData,arguments: {"token":'', "email": argMail.value,"name":''});
            Get.offAllNamed(AppRoutes.instance.signIn);
            } else {
              errorMessage = response.errorMessage;
              hasError.value = true;
              AppSnackBar.error(errorMessage!);
            }
            // Get.back(times: 2);
          }
          else {
            if (response.isSuccess) {
            var verifyToken = response.responseData["data"];
            errorMessage = null;
            message = response.responseData["message"];
            AppSnackBar.success(message!);
            Get.offNamed(AppRoutes.instance.cretaeNewPasswordScreen, arguments: {"verifyToken": verifyToken.toString()}
            );
            }else{
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
    return minutes > 0
        ? '$minutes:${remainingSeconds.toString().padLeft(2, '0')}'
        : '$remainingSeconds';
  }

  bool _isolateRunning = false;

  void startTimer() async {
    if (_isolateRunning) return;  // Prevent multiple isolates
    _isolateRunning = true;

    try {
      final receivePort = ReceivePort();
      _isolate = await Isolate.spawn(_isolateEntryPoint, receivePort.sendPort);

      receivePort.listen((data) {
        _seconds.value = data as int;
        if (_seconds.value <= 0) {
          stopTimer();
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void stopTimer() {
    if (!_isolateRunning) return;
    try {
      _isolate.kill(priority: Isolate.immediate);
    } catch (e) {
      log(e.toString());
    }
    _seconds.value = 0;
    _isolateRunning = false;
  }


  static void _isolateEntryPoint(SendPort sendPort) {
    int seconds = 120;
    void timerCallback(Timer timer) {
      seconds--;
      sendPort.send(seconds);
      if (seconds <= 0) {
        timer.cancel();
      }
    }

    Timer.periodic(const Duration(seconds: 1), timerCallback);
  }

  appClose() {
    try {
      otpController.dispose();
    } catch (e) {
      errorLog("app close", e);
    }
  }

  @override
  void onClose() {
    super.onClose();
    stopTimer();
    appClose();
  }


}

// import 'dart:async';
// import 'dart:developer';
// import 'dart:isolate';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:luggage_tracking/utils/app_all_log/error_log.dart';
// import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';
//
// // class OtpVerificationScreenController extends GetxController {
// //   ///////////////  object and variable
// //   // AuthRepository authRepository = AuthRepository();
// //   RxString argMail = "".obs;
// //   RxBool isEmailVerification = false.obs;
// //   RxBool isLoading = false.obs;
// // ////////////////  form key use for validation
// //   GlobalKey<FormState> verificationCodeKey = GlobalKey<FormState>();
// // ////////////////////  isolate variable
// //   final RxInt _seconds = 0.obs;
// //   RxInt get seconds => _seconds;
// //   late Isolate _isolate;
//
// //   TextEditingController otpText1 = TextEditingController();
// //   TextEditingController otpText2 = TextEditingController();
// //   TextEditingController otpText3 = TextEditingController();
// //   TextEditingController otpText4 = TextEditingController();
// //   TextEditingController otpText5 = TextEditingController();
// //   TextEditingController otpText6 = TextEditingController();
//
// //   setArgData() {
// //     try {
// //       var argData = Get.arguments;
// //       if (argData.runtimeType != Null) {
// //         if (argData is String) {
// //           argMail.value = argData.toString();
// //         } else if (argData is Map) {
// //           argMail.value = argData["email"];
// //           isEmailVerification.value = true;
// //         }
// //       }
// //       startTimer();
// //     } catch (e) {
// //       log("error form otp verification arg set data function : $e");
// //     }
// //   }
//
//
// //   Future<dynamic> otpVerification() async {
// //     // try {
// //     //   return await authRepository.verifyEmail(email: argMail.value, otp: _getOtpNumber());
// //     // } catch (e) {
// //     //   errorLog("otp verification", e);
// //     //   return false;
// //     // }
// //   }
//
// //   Future<void> clickVerificationCodeButton() async {
// //     try {
// //       if (verificationCodeKey.currentState!.validate()) {
// //         isLoading.value = true;
// //         var response = await otpVerification();
// //         if (response != null) {
// //           if (isEmailVerification.value) {
// //             AppSnackBar.success("Your OTP verified");
// //             AppSnackBar.success("Again Credential use and sign-in");
// //             // Get.back(times: 2);
// //           } else {
// //             if (response["data"].runtimeType != Null) {
// //               AppSnackBar.message("Verification Successful: Please securely store and utilize this code for reset password");
// //               // Get.offAndToNamed(AppRoutes.resetPasswordScreen, arguments: response["data"].toString());
// //             }
// //           }
// //         }
// //         isLoading.value = false;
// //       }
// //     } catch (e) {
// //       log("error form click verification code function button : $e");
// //       isLoading.value = false;
// //     }
// //   }
//
// //   String formatTime(int seconds) {
// //     int minutes = seconds ~/ 60;
// //     int remainingSeconds = seconds % 60;
//
// //     if (minutes > 0) {
// //       return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// //     } else {
// //       return '$remainingSeconds';
// //     }
// //   }
//
// //   void startTimer() async {
// //     try {
// //       final receivePort = ReceivePort();
// //       _isolate = await Isolate.spawn(_isolateEntryPoint, receivePort.sendPort);
// //       receivePort.listen((data) {
// //         _seconds.value = data as int;
// //         if (_seconds.value <= 0) {
// //           stopTimer();
// //         }
// //       });
// //     } catch (e) {
// //       log(e.toString());
// //     }
// //   }
//
// //   reCallStatTimer() {
// //     if (seconds.value == 0) {
// //       startTimer();
// //     }
// //   }
//
// // //////////  stop timer and isolate
// //   void stopTimer() {
// //     try {
// //       _isolate.kill(priority: Isolate.immediate);
// //       _seconds.value = 0;
// //     } catch (e) {
// //       log(e.toString());
// //     }
// //   }
//
// //   static void _isolateEntryPoint(SendPort sendPort) {
// //     int seconds = 120;
//
// //     void timerCallback(Timer timer) {
// //       seconds--;
// //       sendPort.send(seconds);
// //       if (seconds <= 0) {
// //         timer.cancel();
// //       }
// //     }
//
// //     Timer.periodic(const Duration(seconds: 1), timerCallback);
// //   }
//
// //   appClose() {
// //     try {
// //       otpText1.dispose();
// //       otpText2.dispose();
// //       otpText3.dispose();
// //       otpText4.dispose();
// //       otpText5.dispose();
// //       otpText6.dispose();
// //     } catch (e) {
// //       errorLog("app close", e);
// //     }
// //   }
//
// //   @override
// //   void onClose() {
// //     super.onClose();
// //     stopTimer();
// //   }
//
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     setArgData();
// //   }
// // }

