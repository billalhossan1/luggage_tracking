import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
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
      backgroundColor: AppColors.instance.purple_500,
      // backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          showCustomBottomSheet();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              AssetsImagesPath
                  .instance
                  .onBoardingImg, // Make sure this image path is correct
              fit: BoxFit.cover,
            ),
            Positioned(
              top: AppSize.size.height * 0.4,
              left: 0,
              right: 0,
              child: Align(
                child: SizedBox(
                  width: AppSize.width(value: 92),
                  height: AppSize.width(value: 92),
                  child: AppImage(path: AssetsIconsPath.instance.onBoardIcon),
                ),
              ),
            ),

            // Overlay content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 90.0,
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
                      data: "Trkli",
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
                  Gap(height: AppSize.width(value: 46)),
                  AppButton(
                    title: "Get Started",
                    borderRadius: BorderRadius.circular(12),
                    titleSize: 20,
                    onTap: () {
                      showCustomBottomSheet();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomBottomSheet() {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.instance.white50,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Icon in circular container
            AppImage(
              path: AssetsIconsPath.instance.appLogoWhiteBg,
              width: AppSize.width(value: 48),
              height: AppSize.width(value: 48),
            ),
            Gap(height: AppSize.width(value: 16)),

            // Title + Subtitle
            Text.rich(
              TextSpan(
                text: 'Track your luggage effortlessly with  ',
                style: TextStyle(
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w400,
                  fontFamily: AppConst.fontFamily1,
                  color: AppColors.instance.black300,
                ),
                children: [
                  TextSpan(
                    text: 'Trkli',
                    style: TextStyle(
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w600,
                      fontFamily: AppConst.fontFamily1,
                      color: AppColors.instance.black300,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Sign in or register now.',
              style: TextStyle(
                fontSize: AppSize.width(value: 16),
                fontWeight: FontWeight.w400,
                fontFamily: AppConst.fontFamily1,
                color: AppColors.instance.black300,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Sign In Button (Outlined)
            SizedBox(
              width: double.infinity,
              height: AppSize.width(value: 50),
              child: OutlinedButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.instance.signIn);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.instance.purple_500),
                  foregroundColor: AppColors.instance.purple_500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Radius 12 px
                  ),
                ),
                child: AppText(
                  data: "Sign In",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.purple_500,
                ),
              ),
            ),

            Gap(height: 20),

            // Registration Button (Filled)
            AppButton(
              title: "Registration",
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Get.toNamed(AppRoutes.instance.signUp);
              },
            ),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
  );
}
