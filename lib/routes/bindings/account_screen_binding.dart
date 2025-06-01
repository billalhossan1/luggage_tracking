import 'package:get/get.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class AccountScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => AccountController());
    Get.put<SaveDataController>(SaveDataController());
  }
}
