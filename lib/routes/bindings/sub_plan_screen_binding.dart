import 'package:get/get.dart';
import 'package:luggage_tracking/screens/sub_plan_screen/controller/sub_plan_screen_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class SubPlanScreenBinding extends Bindings {
  @override
  void dependencies() {  // Add 'void' return type

    Get.put(SaveDataController(), permanent: true);

    Get.lazyPut(() => SubPlanScreenController());
    Get.lazyPut(() => NetworkCaller());
  }
}