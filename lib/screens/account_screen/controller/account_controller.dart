import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/feedback_screen/controller/feedback_screen_controller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

import '../../../const/urls/urls.dart';
import '../../../services/api/network_caller.dart';
import '../../../services/api/network_response.dart';
import '../model/profile_model.dart';

class AccountController extends GetxController{
  Rx<ProfileDetailsModel?> profileModel = Rx<ProfileDetailsModel?>(null);
  var rating = 3.0.obs;
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;
  TextEditingController feedbackMessageTEController = TextEditingController();

  void updateRatting(double value) {
    rating.value = value;
  }
  void onTapLogout() {
    Get.find<SaveDataController>().clearUserData();
    Get.offAllNamed(AppRoutes.instance.signIn);
  }


  Future<void>getProfileDetails() async {
    try {
      Logger().i("getProfileDetails called");
      final NetworkResponse response = await profileApiCall();
      if (response.isSuccess) {
        var data = response.responseData;
        Logger().i("Profile data fetched successfully : $data");
        // Handle the profile data as needed
        ProfileModel profileModel = ProfileModel.fromJson(data);
        this.profileModel = profileModel.data.obs;
        // Logger().e("Profile model created: ${profileModel.data!.name}");


      } else {
        errorMessage.value = response.errorMessage;
        Logger().e("Error message: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      Logger().e(errorMessage.value);
    }
  }
  Future<dynamic>profileApiCall()async{

    if (!Get.isRegistered<SaveDataController>() && !Get.isRegistered<NetworkCaller>()) {
      Get.lazyPut(()=> SaveDataController());
      Get.lazyPut(()=> NetworkCaller());
    }
    final networkCaller = Get.find<NetworkCaller>();
    String? accessToken = await Get.find<SaveDataController>().getUserData();

    return networkCaller.getRequest(
        Urls.getProfileDetailsUrl, accessToken: accessToken);
  }
  Future<void> feedbackSubmit() async {
    Get.lazyPut(()=>FeedbackScreenController());
    Get.find<FeedbackScreenController>().makeFeedBack(feedbackMessageTEController.text.trim(), rating.value);
  }
}