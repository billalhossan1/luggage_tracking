
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/my_plan/controller/my_plan_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class MyPlanScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SaveDataController());
    Get.lazyPut(() => NetworkCaller());
    Get.put(() => MyPlanController());
    // Get.lazyPut(() => TermsAndConditionsScreenController());
    // Get.lazyPut(() => PrivacyPolicyScreenController());
    // Get.lazyPut(() => AboutUsScreenController());
    // Get.lazyPut(() => TaskController());
    // Get.lazyPut(() => MyCartController());
    // Get.lazyPut(() => NavController());
    // Get.lazyPut(() => ShowEmojiController());
    // Get.lazyPut(() => RetailShopListControlelr());
  }
}
