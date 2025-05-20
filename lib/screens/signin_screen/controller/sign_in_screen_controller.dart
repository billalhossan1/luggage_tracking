import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreenController extends GetxController {
  //////////////  variable & object
  RxBool isLoading = RxBool(false);
  RxBool isRememberMe = RxBool(false);
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

  void clickSignIButton() {
    try {
      if (signInFormKey.currentState!.validate()) {
        // signIn();
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
