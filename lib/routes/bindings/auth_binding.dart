import 'package:get/get.dart';
import 'package:luggage_tracking/screens/signin_screen/controller/sign_in_screen_controller.dart';
import 'package:luggage_tracking/screens/signup_screen/controller/sign_up_screen_controller.dart';

class AuthBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SignInScreenController());
    // Get.lazyPut(() => ForgotScreenController());
    // Get.lazyPut(() => OtpVerificationController());
    Get.lazyPut(() => SignUpScreenController());
    // Get.lazyPut(() => ChangePasswordScreenController());
  }
}
