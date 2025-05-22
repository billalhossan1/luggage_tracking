import 'package:get/get.dart';

class AccountController extends GetxController{
  var rating = 3.0.obs;

  void updateRatting(double value) {
    rating.value = value;
  }
}