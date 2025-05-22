import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/screens/splash_screen/controller/splash_screen_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppSize.size = size;
    return GetBuilder(
      init: SplashScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.instance.purple_500,
          body: Obx(
            () => Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: AnimatedOpacity(
                  duration: Duration(seconds: 2),
                  opacity: controller.animation2.value,
                  child: AnimatedScale(
                    scale: controller.animation.value,
                    duration: Duration(seconds: 2),
                    curve: Curves.easeOutExpo,
                    child: AppImage(path: AssetsIconsPath.instance.splashLogo),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
