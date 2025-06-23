import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/device_screen/controller/device_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/model/category_list_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/snackbar_message/snackBar_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AddDeviceController extends GetxController {
  final TextEditingController itemNameController = TextEditingController();
  final MobileScannerController scannerController = MobileScannerController();
  List<CategoryItem> categoryList = [];
  final List<String> categories = [];
  RxString selectedCatId = ''.obs;
  RxString selectedCatName = ''.obs;
  RxBool isLoading = false.obs;
  bool termsAgreed = false;
  String? scannedDeviceId;

  @override
  void onInit() {
    HomeScreenController homeScreenController = Get.find<HomeScreenController>();
    categoryList = homeScreenController.categoryList;
    for (var cat in categoryList) {
      categories.add(cat.name!);
    }
    super.onInit();
  }

  @override
  void onClose() {
    itemNameController.dispose();
    scannerController.dispose();
    super.onClose();
  }

  // Method to get category ID from category name
  String getCatIdFromName(String catName) {
    final category = categoryList.firstWhere(
          (cat) => cat.name == catName,
      orElse: () => CategoryItem(sId: '', name: ''),
    );
    return category.sId ?? '';
  }

  // Validation method
  bool validateInput() {
    if (itemNameController.text.trim().isEmpty) {
      showCustomSnackBar(title: "Error", message: "Device name cannot be empty.");
      return false;
    }

    if (selectedCatId.value.isEmpty) {
      showCustomSnackBar(title: "Error", message: "Please select a category.");
      return false;
    }

    if (!termsAgreed) {
      showCustomSnackBar(title: "Error", message: "You must agree to the terms.");
      return false;
    }

    return true;
  }

  // API call method
  Future<dynamic> apiCall() async {
    Map<String, dynamic> body = {
      "name": itemNameController.text.trim(),
      "category": selectedCatId.value,
      "serial": "adfsdsafhdfsdsfjkaj",
    };
    String? accessToken = await SaveDataController().getUserData();
    return NetworkCaller().postRequest(Urls.getDevicesUrl, body: body, accessToken: accessToken);
  }

  Future<void> onTapConnectDevice() async {
    if (!validateInput()) {
      return;
    }

    isLoading.value = true;
    final NetworkResponse response = await apiCall();
    isLoading.value = false;

    if (response.isSuccess) {
      showCustomSnackBar(title: "Success", message: response.responseData["message"] ?? "Device Connected Successfully");
      Get.find<DeviceScreenController>().getDevices();
      update();
    } else {
      showCustomSnackBar(title: "Failed", message: response.errorMessage);
    }
  }
}
