import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';

ThemeData appThemeData = ThemeData.light(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: AppColors.instance.white200,
  dividerColor: AppColors.instance.black50,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.instance.white200,
    // surfaceTintColor: AppColors.instance.white200,
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.instance.white100),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.instance.white100),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.instance.white100),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.instance.red2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.instance.red2),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.instance.white50,
    iconColor: AppColors.instance.white50,
    shadowColor: AppColors.instance.white50,
    surfaceTintColor: AppColors.instance.white50,
    elevation: 0,
  ),
  buttonTheme: ButtonThemeData(
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      mouseCursor: WidgetStatePropertyAll(MouseCursor.defer),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      mouseCursor: WidgetStatePropertyAll(MouseCursor.defer),
    ),
  ),
);
