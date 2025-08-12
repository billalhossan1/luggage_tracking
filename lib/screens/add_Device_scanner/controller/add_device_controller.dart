import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/screens/device_screen/controller/device_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/model/category_list_model.dart';
import 'package:luggage_tracking/screens/profile_details/controller/profile_details_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/snackbar_message/snack_bar_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

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
    _checkCameraPermission();
    super.onInit();
  }

  @override
  void onClose() {
    itemNameController.dispose();
    scannerController.dispose();
    super.onClose();
  }

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
    bool isSubscribe =Get.find<AccountController>().profileModel.value?.isSubscribed??false;
  if(isSubscribe==false){
    int length = Get.find<DeviceScreenController>().devices.length;
    if (length > 0) {

      return showPremiumPurchaseDialog();
    }
  }

    Map<String, dynamic> body = {
      "name": itemNameController.text.trim(),
      "category": selectedCatId.value,
      "serial": "ffffv",
    };
  isLoading.value=true;
    String? accessToken = await SaveDataController().getUserData();
   NetworkResponse response =await NetworkCaller().postRequest(Urls.getDevicesUrl, body: body, accessToken: accessToken);
    isLoading.value=false;
    return response;

  }

  Future<void> onTapConnectDevice() async {
    if (!validateInput()) {
      return;
    }


    final NetworkResponse response = await apiCall();

    if (response.isSuccess) {
      showCustomSnackBar(title: "Success", message: response.responseData["message"] ?? "Device Connected Successfully");
      Get.find<DeviceScreenController>().getDevices();
      update();
    } else {
      showCustomSnackBar(title: "Failed", message: response.errorMessage ?? "Something went wrong.");
    }
  }

  // Method to check camera permission
  Future<void> _checkCameraPermission() async {
    PermissionStatus permission = await Permission.camera.status;

    if (permission.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      if (status.isGranted) {
        // Permission granted, start the camera
        scannerController.start();
        update(); // Notify the UI that the permission is granted
      } else {
        // Show an error if permission is denied
        showCustomSnackBar(title: 'Permission Denied', message: 'Camera permission is required for scanning QR codes.');
      }
    } else if (permission.isPermanentlyDenied) {
      // If permission is permanently denied, open app settings
      openAppSettings();
    } else {
      // Camera permission is already granted
      scannerController.start();
      update(); // Refresh UI since permission is already granted
    }
  }



  // Show the Premium Subscription Dialog
  Future<void> showPremiumPurchaseDialog() async {
    if(!Get.isRegistered<SaveDataController>()){
      Get.lazyPut(() => SaveDataController());
    }
    String? name = await SaveDataController().getUserName();
    String? email = await SaveDataController().getUserEmail();
    String? token =await SaveDataController().getUserData();
    return Get.dialog(
      AlertDialog(
        title: Text('Premium Subscription Required'),
        content: Text(
            'To add more devices, you need to purchase the premium subscription. Do you want to purchase now?'),
        actions: [
          // No button - dismiss the dialog
          TextButton(
            onPressed: () {
            Navigator.pop(Get.context!);
            },
            child: Text('No'),
          ),
          // Yes button - handle purchase logic here
          TextButton(
            onPressed: ()  {
              Navigator.pop(Get.context!);

              Get.toNamed(AppRoutes.instance.subPlanScreen,arguments: {"email":email,"name":name,"token":token});
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
