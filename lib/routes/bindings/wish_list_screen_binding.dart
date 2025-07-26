import 'package:get/get.dart';
import 'package:luggage_tracking/screens/wish_list_screen/controller/wish_list_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class WishListScreenBinding extends Bindings {
  @override
  void dependencies() {  // Add 'void' return type

    Get.put(SaveDataController());

    // Keep controller as lazyPut since it's screen-specific
    Get.lazyPut(() => NetworkCaller());
    Get.lazyPut(() => WishListController());
  }
}