
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/delivery_details_screen/controller/delivery_details_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class DeliveryDetailsScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SaveDataController());
    Get.lazyPut(() => NetworkCaller());
    Get.lazyPut(() => DeliveryDetailsScreenController());
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
