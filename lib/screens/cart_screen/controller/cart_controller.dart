import 'package:get/get.dart';
import 'package:luggage_tracking/widgets/snackbar_message/snack_bar_widget.dart';

import '../../../const/urls/urls.dart';
import '../../../services/api/network_caller.dart';
import '../../../services/api/network_response.dart';
import '../../../services/save_data/save_data.dart';
import '../model/cart_list_model.dart';

class CartController extends GetxController{
  RxBool isLoading = false.obs;
  num totalPrice= 0;
  int totalQuantity=0;
  RxList<CartItem> cartList = <CartItem>[].obs;
  NetworkCaller networkCaller = NetworkCaller();
  @override
  void onInit() {
    getCartList();
    super.onInit();
  }

  Future<void>getCartList()async{
    isLoading.value=true;
    NetworkResponse response = await cartListApiCall();
    isLoading.value = false;
    if(response.isSuccess){
      CartListModel cartListModel = CartListModel.fromJson(response.responseData);
      cartList.addAll(cartListModel.cartList ?? []);
    }else{
      showCustomSnackBar(title: "error", message: response.errorMessage);
    }
  }

  Future<dynamic> cartListApiCall({int page = 1}) async {
    if(!Get.isRegistered<SaveDataController>()){
      Get.lazyPut(() => SaveDataController());
    }
    final accessToken = await Get.find<SaveDataController>().getUserData();
    Map<String,dynamic>query={
      'page': page.toString()
    };
    final NetworkResponse response = await networkCaller.getRequest(
      Urls.getCartList,
      queryParam: query,
      accessToken: accessToken,
    );
    return response;
  }



  Future<dynamic>increaseApiCall(String cartId)async{
    if(!Get.isRegistered<SaveDataController>()){
      Get.lazyPut(() => SaveDataController());
    }
    Map<String,dynamic>body={
      'cart': cartId
    };
    final accessToken = await Get.find<SaveDataController>().getUserData();
    final NetworkResponse response = await networkCaller.putRequest(
      Urls.getCartList,
      accessToken: accessToken,body: body

    );
    return response;
  }

  Future<dynamic>decreaseApiCall(String cartId)async{
    if(!Get.isRegistered<SaveDataController>()){
      Get.lazyPut(() => SaveDataController());
    }
    Map<String,dynamic>body={
      'cart': cartId
    };
    final accessToken = await Get.find<SaveDataController>().getUserData();
    final NetworkResponse response = await networkCaller.patchRequest(
      Urls.getCartList,
      accessToken: accessToken,body: body
    );
    return response;
  }
}