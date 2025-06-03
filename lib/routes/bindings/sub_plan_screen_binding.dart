import 'package:get/get.dart';
import 'package:luggage_tracking/screens/signup_with_personal_data_screen/controller/signup_with_personal_data_controller.dart';
import 'package:luggage_tracking/screens/splash_screen/controller/splash_screen_controller.dart';
import 'package:luggage_tracking/screens/sub_plan_screen/controller/sub_plan_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class SubPlanScreenBinding extends Bindings {
  @override
  void dependencies() {  // Add 'void' return type
    // Use Get.put() instead of Get.lazyPut() for critical services
    // Get.put(NetworkCaller(), permanent: true);
    Get.put(SaveDataController(), permanent: true);

    // Keep controller as lazyPut since it's screen-specific
    Get.lazyPut(() => SubPlanScreenController());
    Get.lazyPut(() => NetworkCaller());
  }
}