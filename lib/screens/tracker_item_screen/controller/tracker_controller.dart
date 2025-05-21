import 'package:get/get.dart';

class TrackerController extends GetxController {
  RxBool isExpanded = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}
