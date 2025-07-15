

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
    Get.lazyPut(()=>SaveDataController());
    SaveDataController saveDataController=Get.find<SaveDataController>();
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
              bool isSubscribed = response.responseData["data"]["isSubscribed"] ?? false;
              saveDataController.isSubscribe(isSubscribed);
              Logger().i("isSubscribed: $isSubscribed");
              if(isSubscribed){
                saveDataController.saveUserData(accessToken);
                Get.offAllNamed(AppRoutes.instance.navigationScreen,);
                Logger().i("Access Token: $accessToken");

              }
             else{
                AppSnackBar.success(message!);
                Get.toNamed(AppRoutes.instance.subPlanScreen,arguments: {"email":emailTextEditingController.text.trim(),"token":accessToken,"name":""});
              }
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



  Future<void> googleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Get.snackbar('Login cancelled', 'User cancelled Google login');
        return;
      }
      // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      //
      // final appId = googleAuth.idToken ?? googleAuth.accessToken;
      print('=================================${googleUser.id}');
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken != null) {
        await socialLogin(appId: idToken, email: googleUser.email, name: googleUser.displayName ?? '');
      }


    } catch (e) {
      AppSnackBar.error('Google login failed: $e');
      print("Google login error: $e");
    }
  }

  Future<void> facebookLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken?.tokenString;

        if (accessToken != null) {
          // Fetch Facebook user profile with email field
          final userData = await FacebookAuth.instance.getUserData(fields: "email");
          final email = userData['email'] ?? '';
          final name = userData['name'] ?? '';

          Logger().i("Facebook Access Token: $accessToken");
          Logger().i("Facebook User Email: $email");

          await socialLogin(appId: accessToken, email: email, name: name);
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




  Future<void> socialLogin({required String appId,required String email,required String name}) async {
    Map<String,dynamic> body = {
      "appId": appId,
    };
    try {
      final response = await Get.find<NetworkCaller>().postRequest(
        Urls.socialUrl,
        body: body,
      );

      // Check type and decode if needed
      final data = response.responseData is String
          ? jsonDecode(response.responseData)
          : response.responseData as Map<String, dynamic>;

      Logger().i('Social login response data: $data');

      if (response.statusCode == 200) {
        final accessToken = data["data"]?["accessToken"];
        bool isRegister = data["data"]?["isRegister"] ?? false;
        if (accessToken == null) {
          AppSnackBar.error('Access token missing in response');
          return;
        }
        AppSnackBar.success('Login successful: ${data['message']}');
       if(!isRegister){
         bool isSubscribed = data["data"]["isSubscribed"] ?? false;
         if(!isSubscribed){
           Get.lazyPut(()=>SaveDataController());
          Get.find<SaveDataController>().saveUserData(accessToken);
           Get.offAllNamed(AppRoutes.instance.navigationScreen);
           Logger().i("Navigation to Home Screen");
         }
        else{
          Logger().i("Screen: SubPlanScreen");
           Get.toNamed(AppRoutes.instance.subPlanScreen,arguments: {"token": accessToken,"email":email,"name":name});
         }
       }else{
         Logger().i("Screen: SignUpWithPersonalDataScreen");
         //TODO:navigattionscreen
         // await Get.find<SaveDataController>().saveUserData(accessToken);
          Get.offAllNamed(AppRoutes.instance.signUpWithPersonalData,arguments: {"email":email,"name":name,"token":accessToken});
       }
      } else {
          AppSnackBar.error('Login failed: ${data['message'] ?? response.responseData}');
        // log("Social login error: ${response.responseData}");
      }
    } catch (e) {
      AppSnackBar.error('Error during social login: $e');
      log("Social login exception: $e");
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
