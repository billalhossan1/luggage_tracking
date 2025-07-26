import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/screens/device_screen/model/device_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/snackbar_message/snack_bar_widget.dart';

class DeviceScreenController extends GetxController {
  RxBool isLoading = false.obs; // Track loading state
  RxBool isPaginationLoading = false.obs; // Track loading state for pagination
  RxInt selectedItem = 1.obs; // For item selection, as before
  List<Devices> devices = []; // List of devices

  int currentPage = 1;
  int totalPage = 1;
  bool isSubscribe=false;

  ScrollController scrollController = ScrollController();

  @override
  Future<void> onInit() async {
    super.onInit();
    getDevices(); // Load initial devices
    scrollController.addListener(_scrollListener);
    Get.lazyPut(()=>SaveDataController());
    isSubscribe =await Get.find<SaveDataController>().getIsSubscribe();
    Logger().e("===============================$isSubscribe");
  }
  Future<void> onRefresh()async{
    devices.clear();
    update();
    getDevices();
  }

  // Fetch initial devices
  Future<void> getDevices() async {
    isLoading.value = true;
    try {
      final NetworkResponse response = await apiCall(page: currentPage);
      if (response.isSuccess) {
        DeviceModel deviceModel = DeviceModel.fromJson(response.responseData);
        devices.clear();
        devices.addAll(deviceModel.data?.devices ?? []);
        totalPage = deviceModel.data?.pagination?.totalPage ?? 1;
        update();

      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch more devices for pagination
  Future<void> loadMoreDevices() async {
    if (currentPage == totalPage || isPaginationLoading.value) return; // Prevent further loading if no more pages or already loading

    isPaginationLoading.value = true;
    currentPage++;

    try {
      final NetworkResponse response = await apiCall(page: currentPage);
      if (response.isSuccess) {
        DeviceModel deviceModel = DeviceModel.fromJson(response.responseData);
        devices.addAll(deviceModel.data?.devices ?? []);
      } else {
        showCustomSnackBar(title: "Failed", message: response.errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isPaginationLoading.value = false;
    }
  }

  // API call method with pagination support
  Future<dynamic> apiCall({int page = 1}) async {
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    final response = await Get.find<NetworkCaller>().getRequest(
      Urls.getDevicesUrl,
      queryParam: {'page': page.toString()},
      accessToken: accessToken,
    );
    return response;
  }

  // Scroll listener to detect when to load more data
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreDevices(); // Trigger loading more devices when scrolled to the bottom
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
  var profile = Get.find<AccountController>();

  // Select item logic as before
  void selectItem(int? value) {
    selectedItem.value = value ?? 1;
  }
}
