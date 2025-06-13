import 'package:get/get.dart';
import 'package:luggage_tracking/screens/profile_details/controller/profile_details_controller.dart';
import 'package:luggage_tracking/screens/signup_with_personal_data_screen/controller/signup_with_personal_data_controller.dart';
import 'package:luggage_tracking/screens/splash_screen/controller/splash_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class ProductDetailsScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => ProfileDetailsController());
    // Get.lazyPut(() => ErrorScreenController());
    // Get.lazyPut(() => NotFoundScreenController());
  }
}
