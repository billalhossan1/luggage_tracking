
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/screens/device_screen/controller/device_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/screens/navigation_screen/controllers/navigation_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class NavigationScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => NavigationScreenController());
    Get.lazyPut(() => SaveDataController());
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => NetworkCaller());
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => DeviceScreenController());

  }
}
