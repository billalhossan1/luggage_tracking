import 'package:get/get.dart';

class DeviceScreenController extends GetxController {
  RxInt selectedItem = 1.obs;

  void selectItem(int? value) {
    selectedItem.value = value ?? 1;
  }
}
