import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';

import '../../../services/save_data/save_data.dart';
import '../model/order_list_model.dart';

class DealingHistoryScreenController extends GetxController{
  // Define any variables or methods needed for the dealing history screen


  RxBool isLoading = true.obs; // Example variable to track loading state
  RxList<Orders> dealingHistory = <Orders>[].obs; // Example list to hold dealing history items
  @override
  void onInit() {
    loadDealingHistory();
    super.onInit();
    
  }
  
  Future<void> loadDealingHistory() async {
    isLoading.value = true;
    try {
      final response = await apiCall();
      if (response.isSuccess) {
        dealingHistory.clear();
        OrderListModel orderListModel = OrderListModel.fromJson(response.responseData);
        dealingHistory.addAll(orderListModel.data?.orders ?? []);
        Logger().i("Dealing history loaded successfully: ${dealingHistory.length} items");
        Logger().i("imageUrl:${Urls.imageBaseUrl+dealingHistory[0].product!.images![0]}");
      } else {
        String errorMessage = response.errorMessage ?? "Failed to load dealing history";
        print("Error: $errorMessage");
      }
      
    } catch (e) {
      // Handle any errors that occur during data fetching
      print("Error loading dealing history: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<dynamic> apiCall() async {
    final accessToken = await Get.find<SaveDataController>().getUserData();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(Urls.getOrderListUrl,accessToken: accessToken);
    return response;
  }


  @override
  void onClose() {
    // Clean up resources if necessary
    super.onClose();
  }
}