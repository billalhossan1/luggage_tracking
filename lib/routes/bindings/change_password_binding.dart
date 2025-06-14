import 'package:get/get.dart';
import 'package:luggage_tracking/screens/about_screen/controller/about_screen_controller.dart';
import 'package:luggage_tracking/screens/change_password_screen/controller/change_password_controller.dart';
import 'package:luggage_tracking/screens/splash_screen/controller/splash_screen_controller.dart';
import 'package:luggage_tracking/screens/terms_and_condition_screen/controller/terms_and_condition_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class ChangePasswordBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => ChangePasswordController());
    Get.lazyPut<SaveDataController>(()=>SaveDataController());
    Get.lazyPut<NetworkCaller>(()=>NetworkCaller());
    // Get.lazyPut(() => ErrorScreenController());
    // Get.lazyPut(() => NotFoundScreenController());
  }
}
