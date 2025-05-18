import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking/app_entry_point.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // Status bar এর রঙ
      statusBarIconBrightness:
          Brightness.light, // Android এর জন্য আইকনের রঙ (light/dark)
      statusBarBrightness:
          Brightness.dark, // iOS এর জন্য (dark মানে light icons)
    ),
  );
  runApp(const MyApp());
}



