import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            AssetsImagesPath
                .instance
                .onBoardingImg, // Make sure this image path is correct
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: AppSize.width(value: 92),
              height: AppSize.width(value: 92),
              child: AppImage(path: AssetsIconsPath.instance.onBoardIcon),
            ),
          ),

          // Overlay content
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 40.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: "Welcome To",
                  fontSize: AppSize.width(value: 29),
                  fontWeight: FontWeight.w600,
                  color: AppColors.instance.white50,
                ),

                Gap(height: AppSize.width(value: 8)),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: AppText(
                    data: "Trkil",
                    fontSize: AppSize.width(value: 96),
                    fontWeight: FontWeight.w600,
                    color: AppColors.instance.white50,
                  ),
                ),
                Gap(height: AppSize.width(value: 12)),
                AppText(
                  data:
                      "A smart tracking system to make your life\nsmarter, and completely stress-free",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.white600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
