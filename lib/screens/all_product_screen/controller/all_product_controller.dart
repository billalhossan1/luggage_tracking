import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/dealing_history/model/order_list_model.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

import '../../home_screen/model/product_list_model.dart';

class AllProductPaginationController extends GetxController {
  int currentPage = 1;
  int totalPage = 1;
  int limit = 10;
  RxBool isPaginationLoading = false.obs;
  RxList<ProductItem> productListItems = <ProductItem>[].obs;
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

    getProductsList(); // Load initial data
    scrollController.addListener(_scrollListener);
  }


  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      getProductsList();
    }

  }
  Future<dynamic> apiCall({int page = 1}) async {
    final String? accessToken =
        await Get.find<SaveDataController>().getUserData();
    final Map<String, dynamic> queryParams = {
      'page': page.toString(),
      'limit': limit,
    };
    final response = await Get.find<NetworkCaller>().getRequest(
      Urls.getProductListUrl,
      accessToken: accessToken,
      queryParam: queryParams,
    );
    return response;
  }

  Future<void>getProductsList()async{
    if (currentPage == totalPage) return;

    isPaginationLoading.value = true;
    currentPage++;

    try {
      final response = await apiCall(page: currentPage);
      if (response.isSuccess) {
        ProductListModel productListModel = ProductListModel.fromJson(response.responseData);
        productListItems.addAll(productListModel.productList ?? []);
        // Logger().i("Loaded more dealing history: ${dealingHistory.length} items");
      } else {
        String errorMessage = response.errorMessage ?? "Failed to load more dealing history";
        print("Error: $errorMessage");
      }
    } catch (e) {
      print("Error loading more dealing history: $e");
    } finally {
      isPaginationLoading.value = false;
    }
  }

  void onBookMarkToggle(ProductItem product){
    Get.find<HomeScreenController>().onBookMarkTogle(product);
  }
}
