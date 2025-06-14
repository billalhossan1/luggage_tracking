import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/routes/bindings/account_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/app_binding.dart';
import 'package:luggage_tracking/routes/bindings/auth_binding.dart';
import 'package:luggage_tracking/routes/bindings/change_password_binding.dart';
import 'package:luggage_tracking/routes/bindings/dealing_history_binding.dart';
import 'package:luggage_tracking/routes/bindings/delivery_details_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/delivery_details_show_binding.dart';
import 'package:luggage_tracking/routes/bindings/edit_profile_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/faq_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/navigation_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/product_details_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/sign_up_with_personal_data_binding.dart';
import 'package:luggage_tracking/routes/bindings/splash_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/sub_plan_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/termsAndConditionBinding.dart';
import 'package:luggage_tracking/routes/bindings/wish_list_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/work_func_binding.dart';
import 'package:luggage_tracking/screens/about_screen/about_screen.dart';
import 'package:luggage_tracking/screens/account_screen/account_screen.dart';
import 'package:luggage_tracking/screens/account_setting_screen/account_setting_screen.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/add_device_scanner.dart';
import 'package:luggage_tracking/screens/category_screnn/category_screen.dart';
import 'package:luggage_tracking/screens/change_password_screen/chnage_password_screen.dart';
import 'package:luggage_tracking/screens/create_new_password_screen/create_new_password_screen.dart';
import 'package:luggage_tracking/screens/dealing_history/dealing_history.dart';
import 'package:luggage_tracking/screens/delete_account_screen/detele_account_screen.dart';
import 'package:luggage_tracking/screens/delivery_details_screen/delivery_details_screen.dart';
import 'package:luggage_tracking/screens/delivery_details_show/delivery_details_show_screen.dart';
import 'package:luggage_tracking/screens/device_screen/device_screen.dart';
import 'package:luggage_tracking/screens/edit_profile_screen/controler/edit_profile_controller.dart';
import 'package:luggage_tracking/screens/edit_profile_screen/edir_profile_screen.dart';
import 'package:luggage_tracking/screens/faq_screen/faq_screen.dart';
import 'package:luggage_tracking/screens/feedback_screen/feedback_screen.dart';
import 'package:luggage_tracking/screens/find_nearby/find_nearby.dart';
import 'package:luggage_tracking/screens/forget_password_screen/forget_password_screen.dart';
import 'package:luggage_tracking/screens/home_screen/home_screen.dart';
import 'package:luggage_tracking/screens/location_screen/location_screen.dart';
import 'package:luggage_tracking/screens/navigation_screen/navigation_screen.dart';
import 'package:luggage_tracking/screens/notification_screen/notification_screen.dart';
import 'package:luggage_tracking/screens/onboarding_screen/onboarding_screen.dart';
import 'package:luggage_tracking/screens/otp_verification_screen/otp_verification_screen.dart';
import 'package:luggage_tracking/screens/payment_screen/payment_screen.dart';
import 'package:luggage_tracking/screens/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:luggage_tracking/screens/product_category_screen/product_category_screen.dart';
import 'package:luggage_tracking/screens/product_details_screen/product_details_screen.dart';
import 'package:luggage_tracking/screens/profile_details/profile_details_screen.dart';
import 'package:luggage_tracking/screens/share_item_screen/share_item_screen.dart';
import 'package:luggage_tracking/screens/share_item_user_screen/share_item_user_screen.dart';
import 'package:luggage_tracking/screens/signin_screen/signin_screen.dart';
import 'package:luggage_tracking/screens/signup_screen/signup_screen.dart';
import 'package:luggage_tracking/screens/signup_with_personal_data_screen/signup_with_personal_data_screen.dart';
import 'package:luggage_tracking/screens/splash_screen/splash_screen.dart';
import 'package:luggage_tracking/screens/sub_plan_screen/sub_plan_screen.dart';
import 'package:luggage_tracking/screens/terms_and_condition_screen/terms_and_condition_screen.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/tracker_item_screen.dart';
import 'package:luggage_tracking/screens/wish_list_screen/wish_list_screen.dart';
import 'package:luggage_tracking/screens/work_func_screen/work_func_screen.dart';

import 'bindings/feedback_screen_binding.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  //   /////////////////  splash screen start
  GetPage(
    name: AppRoutes.instance.initial,
    binding: SplashScreenBinding(),
    page: () => const SplashScreen(),
    transitionDuration: Duration(milliseconds: 800),
    opaque: false,
  ),

  //////////=======================Auth screen===================
  GetPage(
    name: AppRoutes.instance.signIn,
    binding: AuthBinding(),
    page: () => const SignInScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.signUp,
    binding: AuthBinding(),
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.forgetPasswordScreen,
    binding: AuthBinding(),
    page: () => const ForgetPasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.cretaeNewPasswordScreen,
    binding: AuthBinding(),
    page: () => const CreateNewPasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.onBoardingScreen,
    page: () => const OnboardingScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.subPlanScreen,
    binding: SubPlanScreenBinding(),
    page: () => const SubPlanScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.locationScreen,
    page: () => const LocationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.otpScreen,
    binding: AuthBinding(),
    page: () => const OtpVerificationScreen(),
  ),

  //////////=======================navigation screen===================
  GetPage(
    name: AppRoutes.instance.navigationScreen,
    binding: NavigationScreenBinding(),
    page: () => const NavigationScreen(),
  ),

  ////////====================== BAse Screens===========================
  GetPage(name: AppRoutes.instance.homeScreen, page: () => const HomeScreen()),
  GetPage(
    name: AppRoutes.instance.categoryScreen,
    page: () => const CategoryScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.productCategoryScreen,
    page: () => const ProductCategoryScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.shareItem,
    page: () => const ShareItemScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.shareUserItemScreen,
    binding: AppBinding(),
    page: () => ShareItemUserScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.trackItemScreen,
    page: () => const TrackerItemScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.addDeviceScanner,
    binding: NavigationScreenBinding(),
    page: () => const AddTrkilDeviceScreen(),
  ),
  GetPage(name: AppRoutes.instance.findNearby, page: () => const FindNearby()),
  GetPage(
    name: AppRoutes.instance.productDetailsScreen,
    binding: ProductDetailsScreenBinding(),
    page: () => const ProductDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.deliveryDetainScreen,
    binding: DeliveryDetailsScreenBinding(),
    page: () => const DeliveryDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.deliveryDetainShowScreen,
    binding: DeliveryDetailsShowBinding(),
    page: () => const DeliveryDetailsShowScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.paymentScreen,
    page: () => const PaymentScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.deviceScreen,
    binding: AppBinding(),
    page: () => DeviceScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.signUpWithPersonalData,
    binding: SignUpWithPersonalDataBinding(),
    page: () => SignupWithPersonalDataScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.accountScreen,
    binding: AccountScreenBinding(),
    page: () => AccountScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.wishListScreen,
    binding: WishListScreenBinding(),
    page: () => WishListScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.acoutScreen,
    binding: AccountScreenBinding(),
    page: () => AboutScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.termsAndCondionScreen,
    binding: TermsAndConditionBinding(),
    page: () => TermsAndConditionScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.profileDetailsScreen,
    page: () => ProfileDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.profileEditScreen,
    binding: EditProfileScreenBinding(),
    page: () => ProfileEditScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.dealingHistoryScreen,
    binding: DealingHistoryBinding(),
    page: () => DealingHistoryScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.accountSettingScreen,
    page: () => AccountSettingScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.changePasswordScreen,
    binding: ChangePasswordBinding(),
    page: () => ChangePasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.deleteAccountScreen,
    binding: AccountScreenBinding(),
    page: () => DeteleAccountScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.workFuncScreen,
    binding: WorkFuncBinding(),
    page: () => WorkFuncScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.feedbackScreen,
    binding: FeedbackScreenBinding(),
    page: () => FeedbackScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.privacyAndPolicyScreen,
    page: () => PrivacyAndPolicyScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.faqScreen,
    binding: FaqScreenBinding(),
    page: () => FaqScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.notificationScreen,
    page: () => NotificationScreen(),
  ),
];
