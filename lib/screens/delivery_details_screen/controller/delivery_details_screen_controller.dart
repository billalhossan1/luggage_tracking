import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';

import '../../cart_screen/model/cart_list_model.dart';


class DeliveryDetailsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxList<CartItem>productList = <CartItem>[].obs;
  TextEditingController emailTEController = TextEditingController();
  TextEditingController contactTEController = TextEditingController();
  TextEditingController nameTEController = TextEditingController();
  TextEditingController zipCodeTEController = TextEditingController();
  TextEditingController cityTEController = TextEditingController();
  TextEditingController streetTEController = TextEditingController();
  TextEditingController countryTEController = TextEditingController();
  TextEditingController noteTEController = TextEditingController();
  TextEditingController stateTEController = TextEditingController();
  String totalAddress='';
  int quantity = 1;
  String details = '';
  dynamic totalPrice = 0;
  @override
  void onInit() {
    productList = Get.arguments["products"];
    quantity = Get.arguments["totalQuantity"];
    totalPrice = Get.arguments["totalPrice"];
    details = Get.arguments["details"]??'';
    super.onInit();
  }

  void onTapContinue() {
    if (formKey.currentState?.validate() ?? false) {
      totalAddress = '${streetTEController.text.trim()}, ${cityTEController.text.trim()}, ${stateTEController.text.trim()},${zipCodeTEController.text.trim()},${countryTEController.text.trim()} ';
      print("total======$totalAddress");
      Get.toNamed(
        AppRoutes.instance.deliveryDetainShowScreen,
        arguments: {
          "name": nameTEController.text.trim(),
          "email": emailTEController.text.trim(),
          "contact": contactTEController.text.trim(),
          "address": totalAddress,
          "note": noteTEController.text.trim(),
          "totalQuantity": quantity,
          "totalPrice": totalPrice,
          "productList": productList,
          "details":details
        },
      );
    } else {
      // Form is not valid, show an error or feedback (optional)
    }
  }

}
