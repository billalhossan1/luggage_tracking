import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/screens/cart_screen/model/cart_list_model.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';
import 'package:luggage_tracking/screens/product_details_screen/model/product_details_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';

import '../../../const/urls/urls.dart';
import '../../../services/save_data/save_data.dart';


class ProductDetailsController extends GetxController {
  List<String> images = [];
  ProductItem? productItem;
  RxString selectedImage = ''.obs;
  RxInt quantity = 1.obs;
  RxBool isLoading = false.obs;
  String productId = '';
  RxList<CartItem> makeOrder = <CartItem>[].obs;
  CartItem? cartItem;
  dynamic productPrice = 0;

  onInitialDataLoadFunction() async {
    try {
      productId = Get.arguments['productId'];
      await getProductDetails();

      // Creating CartItem
      cartItem = CartItem(
        sId: '${productId}sg', // Generating unique ID for cart item
        quantity: quantity.value,
        product: productItem,
      );

      productPrice = productItem?.price;
      makeOrder.add(cartItem ?? CartItem()); // Adding the cart item to makeOrder list
      print("===================makeorder =====${makeOrder.length}");

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    onInitialDataLoadFunction();
    super.onInit();
  }

  Future<void> getProductDetails() async {
    isLoading.value = true;
    NetworkResponse response = await productDetailsApiCall();
    isLoading.value = false;
    if (response.isSuccess) {
      ProductDetailsModel productDetailsModel = ProductDetailsModel.fromJson(response.responseData);
      productItem = productDetailsModel.productItem;
      images.addAll(productItem?.images ?? []);
      if (images.isNotEmpty) {
        selectedImage.value = images[0];
      }
    }
  }

  Future<dynamic> productDetailsApiCall() async {
    if (!Get.isRegistered<SaveDataController>()) {
      Get.lazyPut(() => SaveDataController());
    }
    final networkCaller = NetworkCaller();
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    return networkCaller.getRequest(
        Urls.productDetailsUrl(productId), accessToken: accessToken);
  }

  void selectImage(String img) {
    try {
      selectedImage.value = img;
      Logger().i('Selecting image: $img');
    } catch (e) {
      Logger().i('error: $e');
    }
  }

  // Method to increment quantity
  void incrementQuantity() {
    if (quantity.value < 20) {
      quantity.value++;
    }
  }

  // Method to decrement quantity
  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  // Adding the CartItem to the cart (if needed)
  void addProductToCart() {
    if (cartItem != null) {
      makeOrder.add(cartItem!); // Adds the current CartItem to the cart
      // Optionally, you can persist the cart items here
    }
  }
}
