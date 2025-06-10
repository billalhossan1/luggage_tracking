import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class DeliveryDetailsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxString productId = ''.obs;
  TextEditingController emailTEController = TextEditingController();
  TextEditingController contactTEController = TextEditingController();
  TextEditingController addressTEController = TextEditingController();
  TextEditingController noteTEController = TextEditingController();
  RxInt quantity = 1.obs;
  @override
  void onInit() {
    productId.value = Get.arguments["product-id"];
    super.onInit();
  }
  //TODO:eta delivary details show screen a call hobe
  Future<dynamic> apiCall() async {
    Map<String, dynamic> body = {
      "email": emailTEController.text.trim(),
      "contact": contactTEController.text.trim(),
      "note": noteTEController.text.trim(),
      "address": addressTEController.text.trim(),
      "quantity": quantity.value,
      "product": productId.value,
    };
    // if (!Get.isRegistered<SaveDataController>()) {
    //   Get.lazyPut(() => SaveDataController());
    // }
    // if (!Get.isRegistered<NetworkCaller>()) {
    //   Get.lazyPut(() => NetworkCaller());
    // }
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    final response = await Get.find<NetworkCaller>().postRequest(
      Urls.makeOrderListUrl,
      body: body,
      accessToken: accessToken,
    );
    return response;
  }

  Future<void>onTapContinue()async{
    final NetworkResponse response = await apiCall();
    if(response.isSuccess){
      AppSnackBar.message(response.responseData["message"]??"Order Created Successfully");
      Get.back();
    }else{
      AppSnackBar.error(response.responseData["message"]??"Something went Wrong");
    }
  }
}
