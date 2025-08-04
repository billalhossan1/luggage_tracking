import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
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


  onInitialDataLoadFunction(){
    try{
     productId = Get.arguments['productId'];
     getProductDetails();
    }catch (e){
      debugPrint(e.toString());
    }
  }
  @override
  void onInit() {
    onInitialDataLoadFunction();
    super.onInit();

  }

  Future<void>getProductDetails()async{
    isLoading.value = true;
    NetworkResponse response = await productDetailsApiCall();
    isLoading.value = false;
    if(response.isSuccess){
      ProductDetailsModel productDetailsModel = ProductDetailsModel.fromJson(response.responseData);
      productItem = productDetailsModel.productItem;
      images.addAll(productItem?.images ?? []);
      if (images.isNotEmpty) {
        selectedImage.value =  images[0];
      }
    }
  }

  Future<dynamic> productDetailsApiCall() async {
    if (!Get.isRegistered<SaveDataController>() ) {
      Get.lazyPut(() => SaveDataController());
    }
    final networkCaller = NetworkCaller();
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    // _accessToken = accessToken;
    return networkCaller.getRequest(
        Urls.productDetailsUrl(productId), accessToken: accessToken);
  }

  void selectImage(String img) {

   try{
     selectedImage.value = img;
     Logger().i('Selecting image: $img');
     // Logger().i('Old selected image: ${selectedImage.value}');
   }catch(e){
     Logger().i('error: $e');
   }

  }

  // Future<void>getProductDetails(String productId)async{
  //   isLoading.value = true;
  //   await apiCall(productId);
  //   isLoading.value = false;
  // }

  // Future<dynamic> apiCall(String productId) async {
  //   if (!Get.isRegistered<SaveDataController>() && !Get.isRegistered<NetworkCaller>()) {
  //     Get.lazyPut(() => SaveDataController());
  //     Get.lazyPut(() => NetworkCaller());
  //   }
  //   final networkCaller = Get.find<NetworkCaller>();
  //   String? accessToken = await Get.find<SaveDataController>().getUserData();
  //   // Logger().e("Product Access Token: $_accessToken");
  //   return networkCaller.getRequest(
  //       Urls.productDetailsUrl(productId), accessToken: accessToken);
  // }

  void incrementQuantity() {
    if(quantity.value<20){
      quantity.value++;
    }

  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}