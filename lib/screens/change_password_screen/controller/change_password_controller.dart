import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/urls/urls.dart';
import '../../../services/api/network_caller.dart';
import '../../../services/api/network_response.dart';
import '../../../services/save_data/save_data.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../../widgets/snackbar_message/snack_bar_widget.dart';

class ChangePasswordController extends GetxController {
  RxBool inProgress = false.obs;


  String? errorMessage;
  String? message;
  late final String? token;
  ///////////////////  object
  TextEditingController oldPasswordTextEditingController = TextEditingController();
  TextEditingController newPasswordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    try {
      if (formKey.currentState!.validate()) {
        if(newPasswordTextEditingController.text!=confirmPasswordTextEditingController.text){
          showCustomSnackBar(title: 'Failed', message: 'New password and confirm password must be the same',isError: true);
          return;
        }
        inProgress.value = true;
        Map<String, dynamic> body = {
          "newPassword": newPasswordTextEditingController.text,
          "currentPassword": oldPasswordTextEditingController.text,
          "confirmPassword": confirmPasswordTextEditingController.text


        };
        SaveDataController saveDataController = Get.find<SaveDataController>();
        String? token = await saveDataController.getUserData();

        final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.changePasswordUrl, body: body,accessToken: token);
        inProgress.value = false;

        if (response.isSuccess) {
          Get.back();
          AppSnackBar.success("Change Password Successfully");
          errorMessage = null;

        } else {
          errorMessage = response.errorMessage;
          AppSnackBar.error(response.errorMessage);
        }
      }
    } catch (e) {
      errorLog("checkValidation", e);
    }

  }
  void onAppClose() {
    try {
      oldPasswordTextEditingController.dispose();
      newPasswordTextEditingController.dispose();
      confirmPasswordTextEditingController.dispose();
    } catch (e) {
      errorLog('onAppClose', e);
    }
  }

  @override
  void onClose() {
    onAppClose();
    super.onClose();
  }
}
