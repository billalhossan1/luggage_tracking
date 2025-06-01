

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class SignInScreenController extends GetxController {
  //////////////  variable & object
  RxBool isLoading = RxBool(false);
  String? errorMessage;
  String? message;
  RxBool isRememberMe = RxBool(false);
  void onToggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }
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

  Future<dynamic> signIn()async{
    Map<String, dynamic> body = {
      "email": emailTextEditingController.text.trim(),
      "password": passwordTextEditingController.text
    };
    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.loginUrl, body: body);
    return response;
  }

  Future<void> clickSignIButton() async {
    try {
      if (signInFormKey.currentState!.validate()) {
        isLoading.value = true;
        var response =await signIn();
        isLoading.value = false;
        if (response != null) {
            if (response.isSuccess) {
              errorMessage = null;
              message = response.responseData["message"];
              final accessToken = response.responseData["data"]["accessToken"];
              Logger().i("Access Token: $accessToken");
              // Remember Me checked - save persistently
              await Get.find<SaveDataController>().saveUserData(accessToken);

              AppSnackBar.success(message!);
              Get.toNamed(AppRoutes.instance.navigationScreen,);
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
  final _googleSignIn = GoogleSignIn();


  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar('Login cancelled', 'User cancelled Google login');
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final appId = googleAuth.idToken ?? googleAuth.accessToken;

      if (appId != null) {
        await socialLogin(appId, "google");
      }
    } catch (e) {
      AppSnackBar.error('Google login failed: $e');
      log("Google login error: $e");
    }
  }

  Future<void> facebookLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final accessTokenMap = result.accessToken?.toJson();
        final accessToken = accessTokenMap != null ? accessTokenMap['token'] as String? : null;
        Logger().i("Facebook Access Token: $accessToken");

        if (accessToken != null) {
          await socialLogin(accessToken, "facebook");
        } else {
          Get.snackbar('Error', 'Access token is null');
        }
      } else if (result.status == LoginStatus.cancelled) {
        Get.snackbar('Login cancelled', 'User cancelled Facebook login');
      } else {
        Get.snackbar('Error', result.message ?? 'Facebook login failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log("Facebook login error: $e");
    }
  }



  Future<void> socialLogin(String appId, String provider) async {
    final url = Uri.parse(Urls.socialUrl);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "appId": appId,
          "provider": provider,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data["data"]["accessToken"];
        // Remember Me checked - save persistently
        await Get.find<SaveDataController>().saveUserData(accessToken);
        AppSnackBar.success('Login successful: ${data['message']}');
        Get.offAllNamed(AppRoutes.instance.signUpWithPersonalData);
      } else {
        final data = jsonDecode(response.body);
        if (data['message'] == 'Email already exist!') {
          AppSnackBar.error('Email already registered. Please login with email & password.');
          // Optionally navigate to your email/password login screen:
          // Get.toNamed(AppRoutes.instance.signIn);
        } else {
          AppSnackBar.error('Login failed: ${data['message'] ?? response.body}');
        }
        log("Social login error: ${response.body}");
      }
    } catch (e) {
      AppSnackBar.error('Error during social login: $e');
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
