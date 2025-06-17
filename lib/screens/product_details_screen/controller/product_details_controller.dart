import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';

import '../../../services/api/network_caller.dart';
import '../../../services/save_data/save_data.dart';

class ProductDetailsController extends GetxController {
  List<String> images = [];
  ProductItem? productItem;
  RxString selectedImage = ''.obs;
  RxInt quantity = 1.obs;
  RxBool isLoading = false.obs;


  onInitialDataLoadFunction(){
    try{
      productItem = Get.arguments["product"];
      if (productItem != null) {
        images.addAll(productItem?.images ?? []);
        if (images.isNotEmpty) {
          selectedImage.value =  images[0];
        }
      }
      Logger().i("images in product details: $images");
      Logger().i("selected image: ${selectedImage.value}");
    }catch (e){

    }
  }
  @override
  void onInit() {
    onInitialDataLoadFunction();
    super.onInit();

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