import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';
import 'package:luggage_tracking/screens/wish_list_screen/model/wish_list_model.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

import '../../../services/api/network_caller.dart';
import '../../../services/save_data/save_data.dart' show SaveDataController;

class WishListController extends GetxController {
  RxList<WishItem> wishListItems = <WishItem>[].obs;
  RxBool isLoading = false.obs;
  RxBool bookmarkLoading = false.obs;
  RxBool isWishList = true.obs;

  late final SaveDataController _saveDataController;
  late final NetworkCaller _networkCaller;

  @override
  void onInit() {
    super.onInit();
    // Register dependencies here once
    if (!Get.isRegistered<SaveDataController>()) {
      Get.lazyPut(() => SaveDataController());
    }
    if (!Get.isRegistered<NetworkCaller>()) {
      Get.lazyPut(() => NetworkCaller());
    }

    _saveDataController = Get.find<SaveDataController>();
    _networkCaller = Get.find<NetworkCaller>();

    loadWishListItems();
  }

  Future<void> onBookMarkTogle(WishItem product) async {
    // bookMarkApiCall(product.sId!);
    // Toggle the bookmark locally
    // Logger().i("onBookMarkTogle called for product: ${product.sId}, isBookMarked: ${product.bookmark}");

    final NetworkResponse response =await bookMarkApiCall(product.product!.sId!);
    if (!Get.isRegistered<HomeScreenController>()) {
      Get.lazyPut(() => HomeScreenController());
    }

    if (response.isSuccess) {
      loadWishListItems();
      Get.find<HomeScreenController>().getProductList();
      AppSnackBar.message(response.responseData['message'] ?? "Bookmark removed successfully");
    } else {
      AppSnackBar.error(response.errorMessage ?? "Failed to toggle bookmark");
      // Revert the bookmark status locally if API fails
      update();  // Update the UI with the reverted state
    }
    //  Toggle the bookmark status locally
 // Update the UI with the new state

    // Trigger the API call to update the bookmark status

  }

  Future<dynamic> bookMarkApiCall(String productID) async {
    Logger().i("bookMarkApiCall triggered for product: $productID");
    Map<String, dynamic> body = {
      "product": productID,
    };



    String? accessToken = await Get.find<SaveDataController>().getUserData();
    Logger().i("Access token: $accessToken");

    if (accessToken == null) {
      Logger().e("Access Token is null");
      return;
    }

    final response = await Get.find<NetworkCaller>().postRequest(
      Urls.bookMarkUrl,
      body: body,
      accessToken: accessToken,
    );

    // Logger().i("Bookmark API Response: Status Code - ${response.statusCode}");
    // Logger().i("Bookmark API Response Body: ${response.responseData}");

    return response;
  }

  Future<void> loadWishListItems() async {
    isLoading.value = true;
    try {
      final response = await apiCall();

      // Debug: Print the raw response
      Logger().i("Raw API Response: ${response.responseData}");

      if (response.isSuccess) {
        wishListItems.clear();
        WishListModel wishListModel = WishListModel.fromJson(response.responseData);

        // Debug: Check if wishList is parsed correctly
        Logger().i("Parsed wishList count: ${wishListModel.wishList?.length ?? 0}");

        if (wishListModel.wishList != null) {
          for (int i = 0; i < wishListModel.wishList!.length; i++) {
            var item = wishListModel.wishList![i];
            Logger().i("Item $i - ID: ${item.sId}");
            Logger().i("Item $i - Product: ${item.product?.name ?? 'null'}");
            Logger().i("Item $i - Price: ${item.product?.price ?? 'null'}");
            Logger().i("Item $i - Category: ${item.product?.category ?? 'null'}");
          }
        }

        wishListItems.addAll(wishListModel.wishList ?? []);
      } else {
        String errorMessage = response.errorMessage ?? "Failed to load wish list items";
        AppSnackBar.error(errorMessage);
      }
    } catch (e, stackTrace) {
      Logger().e("Error loading wish list: $e");
      Logger().e("Stack trace: $stackTrace");
      AppSnackBar.error("Error loading wish list: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<NetworkResponse> apiCall() async {
    final String? accessToken = await _saveDataController.getUserData();
    final NetworkResponse response = await _networkCaller.getRequest(
      Urls.getWishListUrl,
      accessToken: accessToken,
    );
    return response;
  }
}
