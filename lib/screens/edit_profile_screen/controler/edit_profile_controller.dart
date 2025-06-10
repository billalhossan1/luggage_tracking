import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/screens/account_screen/model/profile_model.dart';
import 'package:luggage_tracking/screens/profile_details/controller/profile_details_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class EditProfileController extends GetxController{
  RxBool isLoading = false.obs;
  RxString selectedCity = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedCountry = ''.obs;
  Rx<Data?> profileModelData= Rx<Data>(Data());
  TextEditingController userNameTEController = TextEditingController();
  TextEditingController emailTEController = TextEditingController();
  TextEditingController contactTEController = TextEditingController();
  TextEditingController dateOfBirthTEController = TextEditingController();
  TextEditingController occupationTEController = TextEditingController();
  TextEditingController addressTEController = TextEditingController();
  RxBool isExpanded = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    profileModelData = Get.arguments["profile-model"];
      if (profileModelData.value != null) {
        userNameTEController.text = profileModelData.value?.name ?? '';
        emailTEController.text = profileModelData.value?.email ?? '';
        contactTEController.text = profileModelData.value?.contact ?? '';
        addressTEController.text = profileModelData.value?.address ?? '';
        occupationTEController.text = profileModelData.value?.occupation ?? '';
        dateOfBirthTEController.text = profileModelData.value?.dateOfBirth ?? '';
        selectedCity.value = profileModelData.value?.city ?? '';
        selectedCountry.value = profileModelData.value?.country ?? '';
        selectedGender.value = profileModelData.value?.gender ?? '';
      }


    super.onInit();
  }


  RxBool isRememberMe = RxBool(false);
  void onToggleIsRemember(){
    isRememberMe.value = !isRememberMe.value;
    update();
  }
  void onSelectCity (String value){
    selectedCity.value = value;
    isExpanded.value=false;
    update();
  }
  void onSelectGender (String value){
    selectedGender.value = value;
    isExpanded.value=false;
    Logger().e(selectedGender);
    update();
  }void onSelectCountry (String value){
    selectedCountry.value = value;
    isExpanded.value=false;
    Logger().e(selectedCountry);
    update();
  }


  Future<void> checkValidation() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      // Proceed with validation and API call if form is valid
      if (isRememberMe.value) {
        isLoading.value = true;
        final NetworkResponse response = await apiCall();
        isLoading.value = false;

        if (response.isSuccess) {


          profileModelData.value = Data(
            name: userNameTEController.text,
            email: emailTEController.text,
            contact: contactTEController.text,
            address: addressTEController.text,
            occupation: occupationTEController.text,
            dateOfBirth: dateOfBirthTEController.text,
            country: selectedCountry.value,
            city: selectedCity.value,
            profile: profileModelData.value?.profile,
            gender: selectedGender.value,
            sId: profileModelData.value?.sId,
          );

// Send updated data back to the previous screen
          Get.back(result: profileModelData.value);
          AppSnackBar.message(response.responseData["message"] ?? "Profile Updated Successfully");
        } else {
          AppSnackBar.error(response.responseData["message"] ?? "Failed Profile Update");
        }
      } else {
        AppSnackBar.error("Allow the Terms and Conditions");
      }
    } else {
      Logger().e('Form validation failed');
    }
  }



  Future<dynamic>apiCall()async{
    Map<String,dynamic>body={
      "name": userNameTEController.text.trim(),
      "email":emailTEController.text.trim(),
      "contact":contactTEController.text.trim(),
      "address":addressTEController.text.trim(),
      "occupation":occupationTEController.text.trim(),
      "dateOfBirth":dateOfBirthTEController.text.trim(),
      "country":selectedCountry.value,
      "city":selectedCity.value,
      "gender":selectedGender.value
    };

    if (!Get.isRegistered<SaveDataController>() && !Get.isRegistered<NetworkCaller>()) {
      Get.lazyPut(()=> SaveDataController());
      Get.lazyPut(()=> NetworkCaller());
    }
    final String? accessToken = await Get.find<SaveDataController>().getUserData();
    final response = await Get.find<NetworkCaller>().patchRequest(Urls.updateProfileUrl,body: body,accessToken: accessToken);
    return response;
  }

}