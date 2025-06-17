import 'package:get/get.dart';
import 'package:luggage_tracking/screens/product_category_screen/controller/product_category_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class ProductCategoryScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => ProductCategoryScreenController());
    Get.lazyPut<SaveDataController>(()=>SaveDataController());
    Get.lazyPut<NetworkCaller>(()=>NetworkCaller());
    // Get.lazyPut(() => ErrorScreenController());
    // Get.lazyPut(() => NotFoundScreenController());
  }
}
