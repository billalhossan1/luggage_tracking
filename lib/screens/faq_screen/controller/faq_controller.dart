import 'package:get/get.dart';

class FaqController extends GetxController {
  // Expanded tile index. -1 means no tile is expanded.
  var expandedIndex = (-1).obs;

  // Toggle expanded state for a specific tile
  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // If the same tile is clicked, collapse it.
    } else {
      expandedIndex.value = index; // Otherwise, expand the clicked tile.
    }
    update();
  }
}


