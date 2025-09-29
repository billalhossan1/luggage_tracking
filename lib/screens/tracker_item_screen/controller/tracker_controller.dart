import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';
import '../../navigation_screen/controllers/navigation_screen_controller.dart';

class TrackerController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool isLoading = true.obs;
  RxBool isActiveSound = false.obs;
  var currentPosition = Rx<LatLng?>(null);
  final initialCameraPosition = LatLng(54.613072699163325, 15.22438119481026);
  RxBool isCurrentLocation = false.obs;
  bool isSubscribed = false;

  Future<void> isSubscribe() async {
    final bool isSubscribe = await SaveDataController().getIsSubscribe();
    isSubscribed = isSubscribe;
  }

  Future<void> initial() async {
    try {
      isLoading.value = true;
      currentPosition.value =
          LatLng(appGlobalLocationData.value?.latitude ?? 54.613072699163325, appGlobalLocationData.value?.longitude ?? 15.22438119481026);
      await isSubscribe();
    } catch (e) {
      errorLog("initial", e);
    }
    isLoading.value = false;
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void soundActive() {
    isActiveSound.value = !isActiveSound.value;
  }

  void goToCurrentLocation(GoogleMapController mapController) {
    if (currentPosition.value != null) {
      final cameraUpdate = CameraUpdate.newLatLngZoom(currentPosition.value!, 16);
      mapController.animateCamera(cameraUpdate);
    }
  }

  @override
  void onInit() {
    initial();
    super.onInit();
  }
}