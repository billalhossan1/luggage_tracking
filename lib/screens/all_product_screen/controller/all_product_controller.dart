import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import '../../../services/api/network_response.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../home_screen/model/product_list_model.dart';
import '../../wish_list_screen/model/wish_list_model.dart';

class AllProductPaginationController extends GetxController {
  RxList<ProductItem> productListItems = <ProductItem>[].obs;
  RxBool isLoading = false.obs;
  // RxBool bookmarkLoading = false.obs;
  RxBool isPaginationLoading = false.obs; // Added for pagination loading state
  // RxBool isWishList = true.obs;

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
    if (!Get.isRegistered<SaveDataController>()) {
      Get.lazyPut(() => SaveDataController());
    }
    if (!Get.isRegistered<NetworkCaller>()) {
      Get.lazyPut(() => NetworkCaller());
    }

    _saveDataController = Get.find<SaveDataController>();
    _networkCaller = Get.find<NetworkCaller>();

    getProductListItems(); // Load initial data
    scrollController.addListener(_scrollListener);
    Logger().e(productListItems.length);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreProductItem();
    }
  }

  Future<void> getProductListItems() async {
    if (isLoading.value || currentPage > totalPage) return;

    isLoading.value = true;

    try {
      final response = await apiCall();

      if (response.isSuccess) {
        ProductListModel productListModel = ProductListModel.fromJson(
          response.responseData,
        );

        // Handle pagination
        totalPage = productListModel.pagination?.totalPage ?? 1;
        currentPage = productListModel.pagination?.page ?? 1;

        // Append new items
        if (productListModel.productList != null) {
          productListItems.addAll(productListModel.productList!);
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
      Urls.getProductListUrl,
      accessToken: accessToken,
      queryParam: queryParams,
    );
    return response;
  }

  Future<void> loadMoreProductItem() async {
    if (currentPage == totalPage) return;

    isPaginationLoading.value = true;
    currentPage++;

    try {
      final response = await apiCall(page: currentPage);
      if (response.isSuccess) {
        ProductListModel productListModel = ProductListModel.fromJson(
          response.responseData,
        );
        productListItems.addAll(productListModel.productList ?? []);
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
    final homeController = Get.find<HomeScreenController>();
    homeController.onBookMarkTogle(product);
    update();
    homeController.getProductList();
    update();
  }
  Future<void> onRefresh()async{
    getProductListItems();

  }

}
