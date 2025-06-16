class AppRoutes {
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  static AppRoutes get instance => _instance;
  /////////////  initial or splash screen
  final String initial = "/";
  final String homeScreen = "/home-screen";
  final String categoryScreen = "/category-screen";
  final String productCategoryScreen = "/product-category-screen";
  final String productDetailsScreen = "/product-details-screen";
  final String navigationScreen = "/navigation-screen";
  final String deliveryDetainScreen = "/delivery-details-screen";
  final String deliveryDetainShowScreen = "/delivery-details-show-screen";
  final String paymentScreen = "/payment-screen";
  final String deviceScreen = "/device-screen";
  final String accountScreen = "/account-screen";
  final String wishListScreen = "/wishlist-screen";
  final String acoutScreen = "/about-screen";
  final String termsAndCondionScreen = "/terms-screen";
  final String profileDetailsScreen = "/profile-details-screen";
  final String profileEditScreen = "/profile-edit-screen";
  final String dealingHistoryScreen = "/dealing-history-screen";
  final String accountSettingScreen = "/account-setting-screen";
  final String changePasswordScreen = "/change-password-screen";
  final String deleteAccountScreen = "/delete-account-screen";
  final String workFuncScreen = "/work-func-screen";
  final String feedbackScreen = "/feedback-screen";
  final String faqScreen = "/faq-screen";
  final String addDeviceScanner = "/add-device-scanner";
  final String notificationScreen = "/notification-screen";
  final String privacyAndPolicyScreen = "/privacy-and-policy-screen";

  ///====================Auth Screen =================
  final String signIn = "/sign-in-screen";
  final String signUp = "/sign-up-screen";
  final String forgetPasswordScreen = "/forget-password-screen";
  final String cretaeNewPasswordScreen = "/create-new-password-screen";
  final String onBoardingScreen = "/onboarding-screen";
  final String subPlanScreen = "/sub-plan-screen";
  final String locationScreen = "/location-screen";
  final String otpScreen = "/otp-screen";
  final String trackItemScreen = "/track-item-screen";
  final String findNearby = "/find-nearby-screen";
  final String shareItem = "/share-item-screen";
  final String shareUserItemScreen = "/share-item-user-screen";
  final String signUpWithPersonalData = "/signup-with-personal-data-screen";
  final String allProductScreen = "/all-product-screen";
}
