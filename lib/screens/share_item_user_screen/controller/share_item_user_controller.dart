import 'package:get/get.dart';

class ShareItemUserController extends GetxController {
  // Tracks which tab is selected (1 or 2)
  var selectedItem = 1.obs;

  // Function to update selected tab
  void selectItem(int? value) {
    if (value != null) {
      selectedItem.value = value;
    }
  }
}
