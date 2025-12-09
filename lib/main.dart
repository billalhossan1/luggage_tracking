import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:luggage_tracking/app_entry_point.dart';
import 'package:luggage_tracking/screens/cart_screen/controller/cart_controller.dart';
import 'package:luggage_tracking/widgets/notification_widget.dart';

import 'firebase_options.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  Get.put(CartController());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().setupFCM();

  runApp(
      const MyApp()
  );
}




