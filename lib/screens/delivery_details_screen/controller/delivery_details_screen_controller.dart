import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';


class DeliveryDetailsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProductItem? product;
  TextEditingController emailTEController = TextEditingController();
  TextEditingController contactTEController = TextEditingController();
  TextEditingController addressTEController = TextEditingController();
  TextEditingController noteTEController = TextEditingController();
  RxInt quantity = 1.obs;
  @override
  void onInit() {
    product = Get.arguments["product"];
    quantity.value = Get.arguments["quantity"];
    super.onInit();
  }

  void onTapContinue() {
    if (formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed to the next screen
      Get.toNamed(
        AppRoutes.instance.deliveryDetainShowScreen,
        arguments: {
          "email": emailTEController.text.trim(),
          "contact": contactTEController.text.trim(),
          "address": addressTEController.text.trim(),
          "note": noteTEController.text.trim(),
          "quantity": quantity.value,
          "product": product
        },
      );
    } else {
      // Form is not valid, show an error or feedback (optional)
    }
  }

}
