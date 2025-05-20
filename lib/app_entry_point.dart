import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_theme.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/routes/app_routes_file.dart';
import 'package:luggage_tracking/utils/app_size.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppSize.size = MediaQuery.of(context).size;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertinoDialog,
      initialRoute: AppRoutes.instance.locationScreen,
      getPages: appRootRoutesFile,
      enableLog: true,
      theme: appThemeData,
      themeMode: ThemeMode.light,
      transitionDuration: const Duration(milliseconds: 300),

      title: 'luggage-tracking',
    );
  }
}
