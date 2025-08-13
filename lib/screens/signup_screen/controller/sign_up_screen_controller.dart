import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';
import '../../../services/api/network_response.dart';
import '../../../utils/app_all_log/error_log.dart';

class SignUpScreenController extends GetxController {
  //////////////  variable & object
  String? errorMessage;
  String? message;
  RxBool isLoading = RxBool(false);
  RxBool isRememberMe = RxBool(false);
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  // final AuthRepository authRepository = AuthRepository();

  //////////  text controller

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController contactTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();

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
    // try {
    //   if (signInFormKey.currentState!.validate()) {
    //     // signIn();
    //   }
    // } catch (e) {
    //   log("error form click SignIn button function : $e");
    // }
  }

  Future<bool> onTapResister() async {
    bool isSuccess = false;

    try {
      if (signUpFormKey.currentState!.validate()) {
        isLoading.value = true;
        update();
        Map<String, dynamic> body = {
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.toLowerCase().trim(),
          "contact": contactTextEditingController.text.trim(),
          "password": passwordTextEditingController.text,
          "confirmPassword": confirmPasswordTextEditingController.text,
        };
        final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(Urls.registerUrl, body: body);
        isLoading.value = false;
        update();
        if (response.isSuccess) {
          errorMessage = null;
          message = response.responseData["message"];
          isSuccess = true;
          AppSnackBar.success(message ?? 'Registration successful');
          Get.toNamed(
            AppRoutes.instance.otpScreen,
            arguments: {
              "email": emailTextEditingController.text.toLowerCase().trim(),
              "isEmailVerification": true,
              "name": nameTextEditingController.text.trim()
            },
          );
        } else {
          errorMessage = response.errorMessage;
          isSuccess = false;
          AppSnackBar.error(errorMessage ?? 'Registration failed');
        }
      }
    } catch (e) {
      errorLog("checkValidation", e);
    }

    return isSuccess;
  }

  appClose() {
    try {
      nameTextEditingController.dispose();
      contactTextEditingController.dispose();
      confirmPasswordTextEditingController.dispose();
      emailTextEditingController.dispose();
      passwordTextEditingController.dispose();
    } catch (e) {
      errorLog("app close sign in page", e);
    }
  }

  // @override
  // void onClose() {
  //   appClose();
  //   super.onClose();
  // }
}
