import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:luggage_tracking/app_entry_point.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(

      const MyApp());
}




