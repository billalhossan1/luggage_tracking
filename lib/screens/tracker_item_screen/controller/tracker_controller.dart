import 'package:get/get.dart';

class TrackerController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool isActiveSound = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void soundActive() {
    isActiveSound.value = !isActiveSound.value;
  }
}
