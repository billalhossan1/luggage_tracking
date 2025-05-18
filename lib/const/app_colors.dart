import 'package:flutter/material.dart';

class AppColors {
  AppColors._privateCobtructor();
  static final AppColors _instance = AppColors._privateCobtructor();
  static AppColors get instance => _instance;
  
  //==============grediant========================

  final Gradient customGradient = LinearGradient(
    colors: [
      Color(0xFFFFD858), // Start color
      Color(0xFFFFB953), // End color (transparent version of last)
      Color(0xFFFF954E), // Fully opaque last color on right
    ],
    stops: [0.3, 0.6, 1.0],
    begin: Alignment(0.00, 7),
    end: Alignment(1.00, 0.50), // End at left
  );
  final Gradient customGradient2 = LinearGradient(
    begin: Alignment(0.50, -0.00),
    end: Alignment(0.50, 1.00),
    colors: [Color(0xFFFEFED6), Color(0xFFFCAC43)],
  );

  //////=========================Purple=========================
  final Color purple_50 = Color(0xfff4e6ff);
  final Color purple_100 = Color(0xffdcb0ff);
  final Color purple_200 = Color(0xffcb8aff);
  final Color purple_300 = Color(0xffb454ff);
  final Color purple_400 = Color(0xffa533ff);
  final Color purple_500 = Color(0xff8f00ff);
  final Color purple_600 = Color(0xff8200e8);
  final Color purple_700 = Color(0xff6600b5);
  final Color purple_800 = Color(0xff4f008c);
  final Color purple_900 = Color(0xff3c006b);

  //////=========================black==============================

  final Color black50 = Color(0xffe7e7e7);
  final Color black100 = Color(0xffb6b6b6);
  final Color black200 = Color(0xff929292);
  final Color black300 = Color(0xff606060);
  final Color black400 = Color(0xff414141);
  final Color black500 = Color(0xff121212);
  final Color black600 = Color(0xff101010);
  final Color black700 = Color(0xff0d0d0d);
  final Color black800 = Color(0xff0a0a0a);
  final Color black900 = Color(0xff080808);

  /////========================white========================

  final Color white50 = Color(0xfffdfdfd);
  final Color white100 = Color(0xfff7f7f7);
  final Color white200 = Color(0xfff4f4f4);
  final Color white300 = Color(0xffeeeeee);
  final Color white400 = Color(0xffebebeb);
  final Color white500 = Color(0xffe6e6e6);
  final Color white600 = Color(0xffd1d1d1);
  final Color white700 = Color(0xffa3a3a3);
  final Color white800 = Color(0xff7f7f7f);
  final Color white900 = Color(0xff616161);

  ////=======================extra color============================

  final Color redLight1 = Color(0xffF57674);
  final Color red1 = Color(0xffFF4040);
  final Color red2 = Color(0xffD32F2F);
  final Color green1 = Color(0xff008000);
  final Color green2 = Color(0xff2E7D32);
  final Color yellow1 = Color(0xffFFC107);
  final Color yellow2 = Color(0xffFBC02D);
  final Color blue1 = Color(0xff1E90FF);
  final Color blue2 = Color(0xff1976D2);
}
