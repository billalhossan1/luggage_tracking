

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class CreateNewPasswordScreenController extends GetxController {
  //////////////  variable & object
  RxBool isLoading = RxBool(false);
  RxBool isRememberMe = RxBool(false);
  RxString verifyToken = ''.obs;
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  // final AuthRepository authRepository = AuthRepository();

  //////////  text controller

  TextEditingController confirmPasswordTextEditingController = TextEditingController();
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


  Future<void> clickSignIButton() async {
    try {
      if (signInFormKey.currentState!.validate()) {
        isLoading.value = true;
        var response = await resetPass();
        isLoading.value = false;
        if (response != null) {
          if (response.isSuccess) {
            AppSnackBar.success(response.responseData["message"] ?? 'Password reset successfully');
            Get.offAllNamed(AppRoutes.instance.signIn);
          } else {
            // log("Reset Password Failed: ${response.errorMessage}");
            AppSnackBar.error(response.errorMessage ?? 'Something went wrong');
          }
        }

      }
    } catch (e) {
      log("error form click SignIn button function : $e");
    }
  }



  @override
  void onInit() {
    final Map<String, dynamic> args = Get.arguments;
    verifyToken.value = args["verifyToken"];
    var logger = Logger();
    logger.i("verifyToken: ${verifyToken.value}");
    super.onInit();
  }

  Future<dynamic> resetPass()async{
    Map<String, dynamic> body = {"newPassword": passwordTextEditingController.text,"confirmPassword": confirmPasswordTextEditingController.text,};

    final NetworkResponse response =
    await Get.find<NetworkCaller>().postRequest(Urls.resetPasswordUrl, body: body,accessToken: verifyToken.value);
    return response;
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
