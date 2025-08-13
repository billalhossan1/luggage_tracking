import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class SignupWithPersonalDataController extends GetxController {
  RxBool isLoading = RxBool(false);
  String argToken = '';
  String argEmail = '';
  String argName = '';
  String? errorMessage;
  String? message;
  TextEditingController contactNumberTextEditingController = TextEditingController();
  TextEditingController dateOfBirthTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController occupationTextEditingController = TextEditingController();
  RxnString selectedCountry = RxnString(null);
  RxnString selectedCity = RxnString(null);
  TextEditingController addressTextEditingController = TextEditingController();

  GlobalKey<FormState> personalDataFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    argToken = Get.arguments['token'] ?? ''.obs;
    argEmail = (Get.arguments['email'] ?? '').toString().toLowerCase();
    argName = Get.arguments['name'] ?? ''.obs;
    Logger().i("Token: $argToken");
    Logger().i("Email: $argEmail");
    Logger().i("Name: $argName");
    // selectedCountry =countryList.first.obs;
    //  selectedCity = cityList.first.obs;
    super.onInit();
  }

  Future<dynamic> updateUSerData() async {
    Map<String, dynamic> body = {
      "contact": contactNumberTextEditingController.text.trim(),
      "country": selectedCountry.value,
      "city": selectedCity.value,
      "address": addressTextEditingController.text,
      "occupation": occupationTextEditingController.text,
      "dateOfBirth": dateOfBirthTextEditingController.text,
      "gender": genderTextEditingController.text,
    };

    if (argEmail.isNotEmpty) {
      body["email"] = argEmail;
    }

    if (argName.isNotEmpty) {
      body["name"] = argName;
    }

    final NetworkResponse response = await Get.find<NetworkCaller>().patchRequest(
      Urls.updateProfileUrl,
      body: body,
      accessToken: 'Bearer $argToken',
    );
    return response;
  }

  Future<void> onTapNext() async {
    if (personalDataFormKey.currentState!.validate()) {
      isLoading.value = true;
      var response = await updateUSerData();
      if (response != null) {
        isLoading.value = false;
        if (response.isSuccess) {
          message = response.responseData["message"];
          errorMessage = null;
          await Get.find<SaveDataController>().saveUserData(argToken);
          await Get.find<SaveDataController>().setUserEmail(argEmail);
          AppSnackBar.success(message ?? "Your Account Created Successfully");
          Get.offAllNamed(
            AppRoutes.instance.subPlanScreen,
            arguments: {"email": argEmail},
          );
          // Optionally, you can navigate to the next screen
          // Get.offAllNamed(AppRoutes.instance.homeScreen);
          // Or if you want to go back to the login screen
          // Get.offAllNamed(AppRoutes.instance.signIn);
        } else {
          Get.snackbar(
            "Error",
            response.errorMessage ?? "Something went wrong",
          );
        }
      } else {
        Get.snackbar("Error", "Failed to update user data");
      }
      isLoading.value = false;
    } else {
      Get.snackbar("Error", "Please fill all fields correctly");
    }
  }

  final List<String> countryList = [
    'Bangladesh',
    'India',
    'United States',
    'Canada',
    'Australia',
  ];
  final List<String> cityList = [
    'New York',
    'London',
    'Tokyo',
    'Paris',
    'Sydney',
    'Toronto',
    'Dubai',
    'Singapore',
    'Los Angeles',
    'Mumbai',
  ];
  void onCountrySelected(String country) {
    selectedCountry.value = country;
  }

  void onCitySelected(String city) {
    selectedCity.value = city;
  }
}
