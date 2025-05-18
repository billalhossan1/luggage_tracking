
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/navigation_screen/controllers/navigation_screen_controller.dart';

class NavigationScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => NavigationScreenController());
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
