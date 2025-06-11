import 'package:get/get.dart';
import 'package:luggage_tracking/screens/account_screen/model/profile_model.dart';

class ProfileDetailsController extends GetxController {

  Rx<ProfileDetailsModel?> profileModel = Rx<ProfileDetailsModel?>(null);

  @override
  void onInit() {
    super.onInit();
    // Ensuring the profileModel is correctly initialized
    profileModel = Get.arguments['profile-model'];
  }
}
