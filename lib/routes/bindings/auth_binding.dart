import 'package:get/get.dart';
import 'package:luggage_tracking/screens/create_new_password_screen/controller/create_new_password_controller.dart';
import 'package:luggage_tracking/screens/forget_password_screen/controller/forget_password_controller.dart';
import 'package:luggage_tracking/screens/otp_verification_screen/controllers/otp_verification_screen_controller.dart';
import 'package:luggage_tracking/screens/signin_screen/controller/sign_in_screen_controller.dart';
import 'package:luggage_tracking/screens/signup_screen/controller/sign_up_screen_controller.dart';

class AuthBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SignInScreenController());
    Get.lazyPut(() => ForgetPasswordScreenController());
    Get.lazyPut(() => OtpVerificationScreenController());
    Get.lazyPut(() => SignUpScreenController());
    Get.lazyPut(() => CreateNewPasswordScreenController());
  }
}
