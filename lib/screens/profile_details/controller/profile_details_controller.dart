import 'package:get/get.dart';
import 'package:luggage_tracking/screens/account_screen/model/profile_model.dart';

class ProfileDetailsController extends GetxController{

  Rx<Data?> profileModel = Rx(Data());

  @override
  void onInit() {
    super.onInit();
    profileModel = Get.arguments['profile-model'];
  }



}