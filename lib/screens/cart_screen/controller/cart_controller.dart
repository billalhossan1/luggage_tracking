import 'package:get/get.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';
import 'package:luggage_tracking/widgets/snackbar_message/snack_bar_widget.dart';

import '../../../const/urls/urls.dart';
import '../../../services/api/network_caller.dart';
import '../../../services/api/network_response.dart';
import '../../../services/save_data/save_data.dart';
import '../model/cart_list_model.dart';

class CartController extends GetxController {
  RxBool isLoading = false.obs;
  num totalPrice = 0;
  int page = 1;
  int totalQuantity = 0;
  RxInt cartCount = 0.obs;
  RxList<CartItem> cartList = <CartItem>[].obs;
  NetworkCaller networkCaller = NetworkCaller();
  @override
  void onInit() {
    getCartList();
    super.onInit();
  }

  Future<void> getCartList() async {
    try {
      final accessToken = await Get.find<SaveDataController>().getUserData();
      if ((accessToken ?? "").isEmpty) {
        return;
      }
      isLoading.value = true;

      NetworkResponse response = await cartListApiCall();
      isLoading.value = false;
      if (response.isSuccess) {
        CartListModel cartListModel = CartListModel.fromJson(response.responseData);
        if (page == 1) {
          cartList.clear();
        }
        cartList.addAll(cartListModel.cartList ?? []);
        cartCount = cartList.length.obs;
        update();
      } else {
        showCustomSnackBar(title: "error", message: response.errorMessage);
      }
    } catch (e) {
      errorLog("getCartList ", e);
    }
  }

  Future<dynamic> cartListApiCall({int page = 1}) async {
    if (!Get.isRegistered<SaveDataController>()) {
      Get.lazyPut(() => SaveDataController());
    }
    final accessToken = await Get.find<SaveDataController>().getUserData();
    Map<String, dynamic> query = {'page': page.toString()};
    final NetworkResponse response = await networkCaller.getRequest(
      Urls.getCartList,
      queryParam: query,
      accessToken: accessToken,
    );
    return response;
  }

  Future<dynamic> increaseApiCall(String cartId) async {
    if (!Get.isRegistered<SaveDataController>()) {
      Get.lazyPut(() => SaveDataController());
    }
    Map<String, dynamic> body = {'cart': cartId};
    final accessToken = await Get.find<SaveDataController>().getUserData();
    final NetworkResponse response = await networkCaller.putRequest(Urls.getCartList, accessToken: accessToken, body: body);
    return response;
  }

  Future<dynamic> decreaseApiCall(String cartId) async {
    if (!Get.isRegistered<SaveDataController>()) {
      Get.lazyPut(() => SaveDataController());
    }
    Map<String, dynamic> body = {'cart': cartId};
    final accessToken = await Get.find<SaveDataController>().getUserData();
    final NetworkResponse response = await networkCaller.patchRequest(Urls.getCartList, accessToken: accessToken, body: body);
    return response;
  }

  Future<void> onTapDelete(String cartId) async {
    isLoading.value = true;
    NetworkResponse response = await deleteApiCall(cartId);
    isLoading.value = false;
    if (response.isSuccess) {
      showCustomSnackBar(title: "Success", message: "Cart deleted");
      getCartList();
    } else {
      showCustomSnackBar(title: "error", message: response.errorMessage);
    }
  }

  Future<dynamic> deleteApiCall(String cartId) async {
    if (!Get.isRegistered<SaveDataController>()) {
      Get.lazyPut(() => SaveDataController());
    }

    final accessToken = await Get.find<SaveDataController>().getUserData();
    final NetworkResponse response = await networkCaller.delRequest(
      Urls.deleteCart(cartId),
      accessToken: accessToken,
      body: {},
    );
    return response;
  }
}
