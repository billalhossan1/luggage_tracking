
import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/routes/bindings/app_binding.dart';
import 'package:luggage_tracking/routes/bindings/navigation_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/splash_screen_binding.dart';
import 'package:luggage_tracking/screens/about_screen/about_screen.dart';
import 'package:luggage_tracking/screens/account_screen/account_screen.dart';
import 'package:luggage_tracking/screens/category_screnn/category_screen.dart';
import 'package:luggage_tracking/screens/dealing_history/dealing_history.dart';
import 'package:luggage_tracking/screens/delivery_details_screen/delivery_details_screen.dart';
import 'package:luggage_tracking/screens/delivery_details_show/delivery_details_show_screen.dart';
import 'package:luggage_tracking/screens/device_screen/device_screen.dart';
import 'package:luggage_tracking/screens/edit_profile_screen/edir_profile_screen.dart';
import 'package:luggage_tracking/screens/home_screen/home_screen.dart';
import 'package:luggage_tracking/screens/navigation_screen/navigation_screen.dart';
import 'package:luggage_tracking/screens/payment_screen/payment_screen.dart';
import 'package:luggage_tracking/screens/product_category_screen/product_category_screen.dart';
import 'package:luggage_tracking/screens/product_details_screen/product_details_screen.dart';
import 'package:luggage_tracking/screens/profile_details/profile_details_screen.dart';
import 'package:luggage_tracking/screens/splash_screen/splash_screen.dart';
import 'package:luggage_tracking/screens/terms_and_condition_screen/terms_and_condition_screen.dart';
import 'package:luggage_tracking/screens/wish_list_screen/wish_list_screen.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  //   /////////////////  splash screen start
  GetPage(
    name: AppRoutes.instance.initial,
    binding: SplashScreenBinding(),
    page: () => const SplashScreen(),
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
    name: AppRoutes.instance.productDetailsScreen,
    binding: AppBinding(),
    page: () => const ProductDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.deliveryDetainScreen,
    page: () => const DeliveryDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.deliveryDetainShowScreen,
    page: () => const DeliveryDetailsShowScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.paymentScreen,
    page: () => const PaymentScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.deviceScreen,
    page: () => const DeviceScreen(),
  ),
  GetPage(name: AppRoutes.instance.accountScreen, page: () => AccountScreen()),
  GetPage(
    name: AppRoutes.instance.wishListScreen,
    page: () => WishListScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.acoutScreen,
    page: () => AboutScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.termsAndCondionScreen,
    page: () => TermsAndConditionScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.profileDetailsScreen,
    page: () => ProfileDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.profileEditScreen,
    page: () => ProfileEditScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.dealingHistoryScreen,
    page: () => DealingHistoryScreen(),
  ),
];
