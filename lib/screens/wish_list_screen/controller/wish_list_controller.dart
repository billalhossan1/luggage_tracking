import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';
import 'package:luggage_tracking/screens/wish_list_screen/model/wish_list_model.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

import '../../../routes/app_routes.dart';
import '../../../services/api/network_caller.dart';
import '../../../services/save_data/save_data.dart' show SaveDataController;

class WishListController extends GetxController {
  RxList<WishItem> wishListItems = <WishItem>[].obs;
  RxBool isLoading = false.obs;
  RxBool bookmarkLoading = false.obs;
  RxBool isPaginationLoading = false.obs; // Added for pagination loading state
  RxBool isWishList = true.obs;

  late final SaveDataController _saveDataController;
  late final NetworkCaller _networkCaller;

  // Pagination variables
  int currentPage = 1;
  int totalPage = 1;
  int limit = 10;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // if (!Get.isRegistered<SaveDataController>()) {
    //   Get.lazyPut(() => SaveDataController());
    // }
    // if (!Get.isRegistered<NetworkCaller>()) {
    //   Get.lazyPut(() => NetworkCaller());
    // }

    _saveDataController = Get.find<SaveDataController>();
    _networkCaller = Get.find<NetworkCaller>();

    getWishListItems(); // Load initial data

    // Ensure that wishListItems is not empty before accessing the first item
    ever(wishListItems, (_) {
      if (wishListItems.isNotEmpty) {
        Logger().i("First item in wishlist: ${wishListItems[0].product?.name}");
      } else {
        Logger().i("WishList is empty.");
      }
    });

    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreWishItem();
    }
  }

  Future<void> getWishListItems() async {
    if (isLoading.value || currentPage > totalPage) return;

    try {
      isLoading.value = true;
      final response = await apiCall();

      if (response.isSuccess) {
        WishListModel wishListModel = WishListModel.fromJson(
          response.responseData,
        );

        // Handle pagination
        totalPage = wishListModel.pagination?.totalPage ?? 1;
        currentPage = wishListModel.pagination?.page ?? 1;

        // Append new items
        if (wishListModel.wishList != null) {
          wishListItems.clear();
          wishListItems.addAll(wishListModel.wishList!);
        }
      } else {
        String errorMessage =
            response.errorMessage ?? "Failed to load wish list items";
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

  Future<NetworkResponse> apiCall({int page = 1}) async {
    final String? accessToken = await _saveDataController.getUserData();

    final Map<String, dynamic> queryParams = {
      'page': page.toString(),
      'limit': limit,
    };

    final NetworkResponse response = await _networkCaller.getRequest(
      Urls.getWishListUrl,
      accessToken: accessToken,
      queryParam: queryParams,
    );
    return response;
  }

  Future<void> loadMoreWishItem() async {
    if (currentPage == totalPage) return;

    isPaginationLoading.value = true;
    currentPage++;

    try {
      final response = await apiCall(page: currentPage);
      if (response.isSuccess) {
        WishListModel wishListModel = WishListModel.fromJson(
          response.responseData,
        );
        wishListItems.addAll(wishListModel.wishList ?? []);
        // Logger().i("Loaded more dealing history: ${dealingHistory.length} items");
      } else {
        String errorMessage =
            response.errorMessage ?? "Failed to load more dealing history";
        print("Error: $errorMessage");
      }
    } catch (e) {
      print("Error loading more dealing history: $e");
    } finally {
      isPaginationLoading.value = false;
    }
  }

  Future<void> onBookMarkTogle(ProductItem product) async {
    final NetworkResponse response = await bookMarkApiCall(
      product.sId!,
    );
    if (!Get.isRegistered<HomeScreenController>()) {
      Get.lazyPut(() => HomeScreenController());
    }

    if (response.isSuccess) {
      getWishListItems(); // Refresh the list after toggling bookmark
      Get.find<HomeScreenController>().getProductList();
      AppSnackBar.message(
        response.responseData['message'] ?? "Bookmark removed successfully",
      );
    } else {
      AppSnackBar.error(response.errorMessage ?? "Failed to toggle bookmark");
    }
  }

  Future<dynamic> bookMarkApiCall(String productID) async {
    Logger().i("bookMarkApiCall triggered for product: $productID");
    Map<String, dynamic> body = {"product": productID};

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

    return response;
  }


}
