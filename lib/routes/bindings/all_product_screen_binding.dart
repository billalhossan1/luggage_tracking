
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/screens/all_product_screen/controller/all_product_controller.dart';
import 'package:luggage_tracking/screens/edit_profile_screen/controler/edit_profile_controller.dart';
import 'package:luggage_tracking/screens/faq_screen/controller/faq_controller.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/screens/navigation_screen/controllers/navigation_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class AllProductScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SaveDataController());
    Get.lazyPut(() => NetworkCaller());
    Get.lazyPut(() => AllProductPaginationController());

  }
}
