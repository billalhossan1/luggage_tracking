import 'package:get/get.dart';
import 'package:luggage_tracking/screens/profile_details/controller/profile_details_controller.dart';

class ProductDetailsScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => ProfileDetailsController());

  }
}
