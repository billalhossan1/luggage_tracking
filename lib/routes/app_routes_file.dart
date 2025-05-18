

import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/routes/bindings/navigation_screen_binding.dart';
import 'package:luggage_tracking/routes/bindings/splash_screen_binding.dart';
import 'package:luggage_tracking/screens/category_screnn/category_screen.dart';
import 'package:luggage_tracking/screens/home_screen/home_screen.dart';
import 'package:luggage_tracking/screens/navigation_screen/navigation_screen.dart';
import 'package:luggage_tracking/screens/product_category_screen/product_category_screen.dart';
import 'package:luggage_tracking/screens/product_details_screen/product_details_screen.dart';
import 'package:luggage_tracking/screens/splash_screen/splash_screen.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
//   /////////////////  splash screen start
  GetPage(name: AppRoutes.instance.initial, binding: SplashScreenBinding(), page: () => const SplashScreen()),



//////////=======================navigation screen===================
GetPage(name: AppRoutes.instance.navigationScreen,binding: NavigationScreenBinding(), page: ()=> const NavigationScreen()),




////////====================== BAse Screens===========================
  GetPage(name: AppRoutes.instance.homeScreen, page: () => const HomeScreen()),
  GetPage(name: AppRoutes.instance.categoryScreen, page: () => const CategoryScreen()),
  GetPage(name: AppRoutes.instance.productCategoryScreen, page: () => const ProductCategoryScreen()),
  GetPage(name: AppRoutes.instance.productDetailsScreen, page: () => const ProductDetailsScreen()),

];
