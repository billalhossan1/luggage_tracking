import 'package:get/get.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/screens/device_screen/controller/device_screen_controller.dart';
import 'package:luggage_tracking/screens/product_details_screen/controller/product_details_controller.dart';
import 'package:luggage_tracking/screens/share_item_user_screen/controller/share_item_user_controller.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/controller/tracker_controller.dart';

class AppBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => ProductDetailsController());
    Get.lazyPut(() => TrackerController());
    Get.lazyPut(() => ShareItemUserController());
    Get.lazyPut(() => DeviceScreenController());
    Get.lazyPut(() => AccountController());

  }
}
