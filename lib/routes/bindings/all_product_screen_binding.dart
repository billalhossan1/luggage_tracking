
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/all_product_screen/controller/all_product_controller.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class AllProductScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SaveDataController());
    Get.lazyPut(() => NetworkCaller());
    Get.lazyPut(() => AllProductPaginationController());
    Get.lazyPut(() => HomeScreenController());

  }
}
