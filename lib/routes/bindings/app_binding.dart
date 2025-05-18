import 'package:get/get.dart';
import 'package:luggage_tracking/screens/product_details_screen/controller/product_details_controller.dart';

class AppBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => ProductDetailsController());
  }
}
