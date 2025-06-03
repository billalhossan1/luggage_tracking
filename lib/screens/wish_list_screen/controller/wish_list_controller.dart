import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/wish_list_screen/model/wish_list_model.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

import '../../../services/api/network_caller.dart';
import '../../../services/save_data/save_data.dart' show SaveDataController;

class WishListController extends GetxController {
  RxList<WishItem> wishListItems = <WishItem>[].obs;
  RxBool isLoading = false.obs;

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

  Future<void> loadWishListItems() async {
    if (isLoading.value) return; // Prevent multiple calls

    isLoading.value = true;
    try {
      final response = await apiCall();
      if (response.isSuccess) {
        wishListItems.clear();
        WishListModel wishListModel = WishListModel.fromJson(response.responseData);
        wishListItems.addAll(wishListModel.wishList ?? []);
      } else {
        String errorMessage = response.errorMessage ?? "Failed to load wish list items";
        AppSnackBar.error(errorMessage);
      }
    } catch (e) {
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
