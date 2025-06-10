import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/account_screen/model/profile_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class EditProfileController extends GetxController{
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
    userNameTEController.text = profileModelData.value?.name ?? '';
    emailTEController.text = profileModelData.value?.email ?? '';
    contactTEController.text = profileModelData.value?.contact ?? '';
    addressTEController.text = profileModelData.value?.address ?? '';
    occupationTEController.text = profileModelData.value?.occupation ?? '';
    dateOfBirthTEController.text = profileModelData.value?.dateOfBirth ?? '';

    selectedCity.value = profileModelData.value?.city ?? '';
    selectedCountry.value = profileModelData.value?.country ?? '';
    selectedGender.value = profileModelData.value?.gender ?? '';
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
    Logger().e(selectedCity);
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
    if (formKey.currentState?.validate() ?? false) {
    final NetworkResponse response =await apiCall();
      if(response.isSuccess){
        AppSnackBar.message(response.responseData["message"]??"Profile Updated Successfully");
      }else{
        AppSnackBar.error(response.responseData["message"]??"Failed Profile Update");

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

    //TODO:binding
    final String? accessToken = await Get.find<SaveDataController>().getUserData();
    final response = await Get.find<NetworkCaller>().patchRequest(Urls.updateProfileUrl,body: body,accessToken: accessToken);
    return response;
  }

}