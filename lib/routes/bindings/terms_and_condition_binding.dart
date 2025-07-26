import 'package:get/get.dart';
import 'package:luggage_tracking/screens/terms_and_condition_screen/controller/terms_and_condition_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class TermsAndConditionBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => TermsAndConditionController());
    Get.lazyPut<SaveDataController>(()=>SaveDataController());
    Get.lazyPut<NetworkCaller>(()=>NetworkCaller());

  }
}
