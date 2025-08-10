import 'package:get/get.dart';
import 'package:luggage_tracking/screens/cart_screen/controller/cart_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class CartScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => CartController());
    Get.lazyPut<SaveDataController>(()=>SaveDataController());
    Get.lazyPut<NetworkCaller>(()=>NetworkCaller());

  }
}
