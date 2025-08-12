import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/cart_screen/model/cart_list_model.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:luggage_tracking/widgets/payment_web_view_widget/product_payment_web_view.dart';

class DeliveryDetailsShowScreenController extends GetxController {
  String? responseUrl;
  RxList<CartItem>? productList = <CartItem>[].obs;
  String? email;
  RxBool isLoading = false.obs;
  String? contact;
  String? note;
  String? address;
  String details='';
  int? quantity;
  num totalPrice=0;

  @override
  void onInit() {
    String myNote = Get.arguments["note"];
    productList = Get.arguments["productList"];
    email = Get.arguments["email"];
    contact = Get.arguments["contact"];
    if (myNote.isNotEmpty) {
      note = Get.arguments["note"];
    }
    quantity=Get.arguments['totalQuantity'];
    totalPrice=Get.arguments['totalPrice'];
    address = Get.arguments["address"];
    details = Get.arguments["details"];

    // Logger().i("productName :${product!.name}");
    // Logger().i("email :$email");
    // Logger().i("contact :$contact");
    // Logger().i("address :$address");
    // Logger().i("quantity :$quantity");

    super.onInit();
  }

  Future<dynamic> apiCall() async {
    Map<String, dynamic> body = {
      "email": email,
      "contact": contact,
      "note": note,
      "address": address,
      "delivery_charge": 4.30,
      "price":totalPrice
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

  Future<void> onTapContinue(BuildContext context) async {
    isLoading.value = true;
    final NetworkResponse response = await apiCall();
    isLoading.value = false;
    if (response.isSuccess) {
      AppSnackBar.message(response.responseData["message"] ?? "Order Created Successfully");
      responseUrl = response.responseData["data"];
      if (context.mounted) {
        productWebView(context, responseUrl!);
      }
      Get.back();
    } else {
      AppSnackBar.error(response.responseData["message"] ?? "Something went Wrong");
    }
  }
}
