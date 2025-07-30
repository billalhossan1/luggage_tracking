import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class DeleteAccountController extends GetxController{
  TextEditingController passwordTEController = TextEditingController();
  RxBool inProgress = false.obs;

  Future<void>deleteAccount()async{
    // if (!Get.isRegistered<SaveDataController>() && !Get.isRegistered<NetworkCaller>()) {
    //   Get.lazyPut(() => SaveDataController());
    //   Get.lazyPut(() => NetworkCaller());
    // }
    final Map<String,dynamic>body={
      "password": passwordTEController.text
    };
    try{
      inProgress.value =true;
      final String? accessToken =await Get.find<SaveDataController>().getUserData();
      final response = await Get.find<NetworkCaller>().delRequest(Urls.deleteAccountUrl, body: body,accessToken: accessToken);
      inProgress.value = false;
      if(response.isSuccess){
        AppSnackBar.message("Account Deleted Successfully");
        Get.find<SaveDataController>().clearUserData();
        Get.offAllNamed(AppRoutes.instance.signIn);
      }else{
        AppSnackBar.error(response.errorMessage);
      }
    }catch(e)
    {
      AppSnackBar.error("Something Went Wrong");
      Logger().e(e.toString());
    }
  }
}
