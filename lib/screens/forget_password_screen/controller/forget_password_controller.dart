

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class ForgetPasswordScreenController extends GetxController {
  //////////////  variable & object
  RxBool isLoading = RxBool(false);
  // RxBool isRememberMe = RxBool(false);
  String? errorMessage;
  String? message;
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  // final AuthRepository authRepository = AuthRepository();

  //////////  text controller

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  // Future<void> signIn() async {
  //   try {
  //     isLoading.value = true;
  //     // var repoResponse = await authRepository.signIn(email: emailTextEditingController.text, password: passwordTextEditingController.text);
  //     if (repoResponse != null) {
  //       Get.offAllNamed(AppRoutes.navigationScreen, arguments: repoResponse);
  //     }
  //     isLoading.value = false;
  //   } catch (e) {
  //     errorLog("sign in function", e);
  //     isLoading.value = false;
  //   }
  // }

  Future<dynamic> forgot()async{
    Map<String, dynamic> body = {"email": emailTextEditingController.text.trim(),};
    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.forgotPasswordUrl, body: body);
    return response;
  }

  Future<void> clickSignIButton() async {
    try {
      if (signInFormKey.currentState!.validate()) {
        isLoading.value = true;
       var response = await forgot();
        isLoading.value = false;
        if (response != null) {
          if (response.isSuccess) {
            errorMessage = null;
            message = response.responseData["message"];

            AppSnackBar.success(message!);
            Get.offNamed(AppRoutes.instance.otpScreen,arguments: {
              "email": emailTextEditingController.text.trim(),
              "isEmailVerification":false
            });
          } else {
            errorMessage = response.errorMessage;
            AppSnackBar.error(errorMessage!);
          }
          // Get.back(times: 2);

        }

      }
    } catch (e) {
      log("error form click SignIn button function : $e");
    }
  }

  // appClose() {
  //   try {
  //     emailTextEditingController.dispose();
  //     passwordTextEditingController.dispose();
  //   } catch (e) {
  //     errorLog("app close sign in page", e);
  //   }
  // }

  // @override
  // void onClose() {
  //   appClose();
  //   super.onClose();
  // }
}
