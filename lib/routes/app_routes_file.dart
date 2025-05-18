

import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/routes/bindings/splash_screen_binding.dart';
import 'package:luggage_tracking/screens/home_screen/home_screen.dart';
import 'package:luggage_tracking/screens/splash_screen/splash_screen.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
//   /////////////////  splash screen start
  GetPage(name: AppRoutes.instance.initial, binding: SplashScreenBinding(), page: () => const SplashScreen()),




////////====================== BAse Screens===========================
  GetPage(name: AppRoutes.instance.homeScreen, page: () => const HomeScreen()),

];
