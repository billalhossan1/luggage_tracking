import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import '../../../services/save_data/save_data.dart';
import '../model/order_list_model.dart';

class DealingHistoryScreenController extends GetxController {
  RxBool isLoading = true.obs; // Track loading state
  RxBool isPaginationLoading = false.obs; // Track loading state for pagination
  RxList<Order> dealingHistory = <Order>[].obs; // List of orders
  int currentPage = 1;
  int totalPage = 1;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadDealingHistory();
    scrollController.addListener(_scrollListener);
  }

  Future<void> loadDealingHistory() async {
    // if (isLoading.value || isPaginationLoading.value) return;

    isLoading.value = true;

    try {
      final response = await apiCall();
      if (response.isSuccess) {
        dealingHistory.clear();
        OrderListModel orderListModel = OrderListModel.fromJson(response.responseData);
        dealingHistory.addAll(orderListModel.data?.orders ?? []);
        totalPage = orderListModel.data?.pagination?.totalPage ?? 1;

        Logger().i("Dealing history loaded successfully: ${dealingHistory.length} items");
        Logger().i("Image URL: ${Urls.imageBaseUrl + dealingHistory[0].product!.images![0]}");
      } else {
        String errorMessage = response.errorMessage ?? "Failed to load dealing history";
        print("Error: $errorMessage");
      }
    } catch (e) {
      // Handle errors
      print("Error loading dealing history: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreDealingHistory() async {
    if (currentPage == totalPage) return;

    isPaginationLoading.value = true;
    currentPage++;

    try {
      final response = await apiCall(page: currentPage);
      if (response.isSuccess) {
        OrderListModel orderListModel = OrderListModel.fromJson(response.responseData);
        dealingHistory.addAll(orderListModel.data?.orders ?? []);
        Logger().i("Loaded more dealing history: ${dealingHistory.length} items");
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

  Future<dynamic> apiCall({int page = 1}) async {
    final accessToken = await Get.find<SaveDataController>().getUserData();
    Map<String,dynamic>query={
      'page': page.toString()
    };
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.getOrderListUrl,
      queryParam: query,
      accessToken: accessToken,
    );
    return response;
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreDealingHistory();
    }
  }

  void onTapBuyAgain(ProductItem product){
    Get.toNamed(AppRoutes.instance.productDetailsScreen,arguments: { "product": product});
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }


}
