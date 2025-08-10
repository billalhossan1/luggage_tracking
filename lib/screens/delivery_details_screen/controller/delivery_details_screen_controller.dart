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
  TextEditingController zipCodeTEController = TextEditingController();
  TextEditingController cityTEController = TextEditingController();
  TextEditingController streetTEController = TextEditingController();
  TextEditingController addressTEController = TextEditingController();
  TextEditingController noteTEController = TextEditingController();
  String totalAddress='';
  int quantity = 1;
  dynamic totalPrice = 0;
  @override
  void onInit() {
    productList = Get.arguments["products"];
    quantity = Get.arguments["totalQuantity"];
    totalPrice = Get.arguments["totalPrice"];
    super.onInit();
  }

  void onTapContinue() {
    if (formKey.currentState?.validate() ?? false) {
      totalAddress = '${zipCodeTEController.text.trim()}, ${cityTEController.text.trim()},${streetTEController.text.trim()},${addressTEController.text.trim()} ';
      Get.toNamed(
        AppRoutes.instance.deliveryDetainShowScreen,
        arguments: {
          "email": emailTEController.text.trim(),
          "contact": contactTEController.text.trim(),
          "address": totalAddress,
          "note": noteTEController.text.trim(),
          "totalQuantity": quantity,
          "totalPrice": totalPrice,
          "productList": productList
        },
      );
    } else {
      // Form is not valid, show an error or feedback (optional)
    }
  }

}
