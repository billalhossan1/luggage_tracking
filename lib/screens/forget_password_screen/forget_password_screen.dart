import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/screens/forget_password_screen/controller/forget_password_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/app_input_widget_two.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordScreenController>(
      init: ForgetPasswordScreenController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(AppSize.width(value: 16)),
                child: Obx(() => SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(height: AppSize.height(value: 40)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppImage(
                            path: AssetsIconsPath.instance.appLogoCircle,
                            width: AppSize.width(value: 48),
                            height: AppSize.width(value: 48),
                          ),
                          Gap(height: 10,),
                          AppText(
                            data: "Forgot password?!",
                            color: AppColors.instance.black900,
                            fontSize: AppSize.width(value: 24),
                            fontWeight: FontWeight.w600,
                          ),
                          Gap(height: 10,),
                          AppText(
                            data: "Enter your email below to reset your password",
                            color: AppColors.instance.white700,
                            fontSize: AppSize.width(value: 18),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Gap(height: AppSize.height(value: 40)),
                      Form(
                        key: controller.signInFormKey,
                        child: Column(
                          children: [
                            AppInputWidgetTwo(
                              hintText: "Email",
                              filled: true,
                              isEmail: true,
                              controller: controller.emailTextEditingController,
                              contentPadding: EdgeInsets.symmetric(),

                            ),
                            Gap(height: 16),
                            AppButton(
                              borderRadius: BorderRadius.circular(12),
                              isLoading: controller.isLoading.value,
                              onTap: () {
                                controller.clickSignIButton();
                              },
                              title: "Reset Password",
                              titleSize: AppSize.width(value: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ),
        );
      },
    );
  }
}
