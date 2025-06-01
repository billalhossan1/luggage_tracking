import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:luggage_tracking/app_entry_point.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(
      const MyApp());
}




