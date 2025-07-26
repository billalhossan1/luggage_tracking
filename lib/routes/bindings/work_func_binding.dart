import 'package:get/get.dart';
import 'package:luggage_tracking/screens/work_func_screen/controller/work_func_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class WorkFuncBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => WorkFuncController());
    Get.lazyPut<SaveDataController>(()=>SaveDataController());
    Get.lazyPut<NetworkCaller>(()=>NetworkCaller());
    // Get.lazyPut(() => ErrorScreenController());
    // Get.lazyPut(() => NotFoundScreenController());
  }
}
