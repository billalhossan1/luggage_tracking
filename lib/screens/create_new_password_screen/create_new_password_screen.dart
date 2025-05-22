import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/signin_screen/controller/sign_in_screen_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/app_input_widget_two.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInScreenController>(
      init: SignInScreenController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(AppSize.width(value: 16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(height: AppSize.height(value: 40)),
                    Column(
                      spacing: AppSize.width(value: 8),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppImage(
                          path: AssetsIconsPath.instance.appLogoCircle,
                          width: AppSize.width(value: 48),
                          height: AppSize.width(value: 48),
                        ),
                        AppText(
                          data: "Create New Password",
                          color: AppColors.instance.black900,
                          fontSize: AppSize.width(value: 24),
                          fontWeight: FontWeight.w600,
                        ),
                        AppText(
                          data:
                              "Your new password must be different from previous passwords.",
                          color: AppColors.instance.white700,
                          fontSize: AppSize.width(value: 18),
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Gap(height: AppSize.height(value: 40)),
                    Form(
                      // key: controller.signInFormKey,
                      child: Column(
                        children: [
                          AppInputWidgetTwo(
                            hintText: "Password",
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(),
                            controller: controller.emailTextEditingController,
                          ),
                          Gap(height: 16),
                          AppInputWidgetTwo(
                            hintText: "Confirm Password",
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(),
                            controller: controller.emailTextEditingController,
                          ),
                          Gap(height: 16),
                          AppButton(
                            borderRadius: BorderRadius.circular(12),
                            isLoading: controller.isLoading.value,
                            onTap: () {
                              Get.offAllNamed(AppRoutes.instance.signIn);
                            },
                            title: "Continiue",
                            titleSize: AppSize.width(value: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
