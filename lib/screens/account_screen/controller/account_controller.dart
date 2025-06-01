import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class AccountController extends GetxController{
  var rating = 3.0.obs;

  void updateRatting(double value) {
    rating.value = value;
  }
  void onTapLogout() {
    Get.put(SaveDataController()).clearUserData();
    Get.offAllNamed(AppRoutes.instance.signIn);
  }
}