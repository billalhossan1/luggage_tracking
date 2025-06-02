import 'package:get/get.dart';
import 'package:luggage_tracking/screens/splash_screen/controller/splash_screen_controller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class SplashScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut<SaveDataController>(()=>SaveDataController());
    // Get.lazyPut(() => ErrorScreenController());
    // Get.lazyPut(() => NotFoundScreenController());
  }
}
