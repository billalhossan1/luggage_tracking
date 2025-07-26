import 'package:get/get.dart';
import 'package:luggage_tracking/screens/delete_account_screen/controller/delete_account_controller.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class DeleteAccountScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => DeleteAccountController());
    Get.lazyPut(() => NetworkCaller());
    Get.lazyPut<SaveDataController>(()=>SaveDataController());
    // Get.lazyPut(() => ErrorScreenController());
    // Get.lazyPut(() => NotFoundScreenController());
  }
}
