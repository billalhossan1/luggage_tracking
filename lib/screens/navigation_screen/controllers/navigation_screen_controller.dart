import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';
import 'package:luggage_tracking/utils/location_utils.dart';
import '../../../services/save_data/save_data.dart';

/////////  variable
Rxn<Position> appGlobalLocationData = Rxn();

class NavigationScreenController extends GetxController {
  RxInt selectedIndex = RxInt(0);

  bool isLoading = true;
  bool isExpanded = false;

  void toggleExpansion() {
    isExpanded = !isExpanded;
    update();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  bool isSubscribe = false;
  @override
  void onInit() {
    initial();
    super.onInit();
  }

  Future<void> initial() async {
    try {
      isLoading = true;
      update(); // Add this to update UI when loading starts

      isSubscribe = await SaveDataController().getIsSubscribe();
      appGlobalLocationData.value = await appUserGeoLocation();
       Logger().i("NAV");
    } catch (e) {
      errorLog("initial", e);
    }
    isLoading = false;
    update();
  }

// @override
// void onClose() {
//   appUserData.dispose();
//   super.onClose();
// }
}