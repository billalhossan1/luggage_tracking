import 'package:get/get.dart';
import 'package:luggage_tracking/screens/cart_screen/controller/cart_controller.dart';

import '../../../const/urls/urls.dart';
import '../../../services/api/network_caller.dart';
import '../../../services/api/network_response.dart';
import '../../../services/save_data/save_data.dart';
import '../../../widgets/snackbar_message/snack_bar_widget.dart';

class AddToCartController extends GetxController{
  RxBool isLoading =false.obs;


  Future<void>addToCart({int quantity=1,required String productId})async{

    isLoading.value = true;
    NetworkResponse response = await addCartApiCall(quantity, productId);
    isLoading.value = false;
    if(response.isSuccess){
      showCustomSnackBar(title: "Success", message: "Product added to cart");
      Get.find<CartController>().getCartList();
    }else{
      showCustomSnackBar(title: "error", message: response.errorMessage,isError: true);
    }
  }

  Future<dynamic>addCartApiCall(int quantity,String productId)async{

    Map<String,dynamic>body={
      'product': productId,
      'quantity':quantity
    };
    final accessToken = await SaveDataController().getUserData();
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.getCartList,
        accessToken: accessToken,body: body

    );
    return response;
  }
}