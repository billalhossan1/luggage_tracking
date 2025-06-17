import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

import '../../home_screen/model/product_list_model.dart';

class ProductCategoryScreenController extends GetxController{
  RxString catId = ''.obs;
  RxString catName = ''.obs;
  int currentPage = 1;
  int totalPage = 1;
  int limit = 10;
  RxBool isLoading = false.obs;
  RxBool isPaginationLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<ProductItem> productList = <ProductItem>[].obs;
  ScrollController scrollController = ScrollController();

  @override

  void onInit() {
    catId.value = Get.arguments['category-id'];
    catName.value = Get.arguments['category-name'];
    getProductList();
    scrollController.addListener(_scrollListener);
    super.onInit();

  }
  
  
  Future<dynamic>apiCall({int page =1})async{
    Map<String,dynamic>queryParams={
      "category":catId
    };
    final String? accessToken = await Get.find<SaveDataController>().getUserData();
    final response = await Get.find<NetworkCaller>().getRequest(Urls.getProductListUrl,accessToken: accessToken,queryParam: queryParams);
    return response;
  }
  Future<void> getProductList() async {
    isLoading.value = true;
    try {
      final response = await apiCall();
      if (response.isSuccess) {
        productList.clear();
        var data = response.responseData;
        ProductListModel productListModel = ProductListModel.fromJson(data);
        productList.clear();
        productList.addAll(productListModel.productList ?? []);
        Logger().i("Product list updated: ${productList.length} items");
        // message.value = "Product list fetched successfully";
      } else {
        errorMessage.value = response.errorMessage ?? "Failed to fetch product list";
        AppSnackBar.error(errorMessage.value);
        Logger().e("Error message: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      Logger().e(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> loadMoreProductItem() async {
    // Logger().i("${currentPage},${totalPage}");
    if (currentPage > totalPage) return;

    isPaginationLoading.value = true;
    currentPage++;

    try {
      final response = await apiCall(page: currentPage);
      if (response.isSuccess) {
        ProductListModel productListModel = ProductListModel.fromJson(
          response.responseData,
        );
        productList.addAll(productListModel.productList ?? []);
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
  Future<void> onRefresh()async{
    getProductList();

  }
  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreProductItem();
    }
  }
  void onBookMarkToggle(ProductItem product){
    final homeController = Get.find<HomeScreenController>();
    homeController.onBookMarkTogle(product);
    update();
    homeController.getProductList();
  }
}