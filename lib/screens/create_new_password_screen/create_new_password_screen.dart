import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/screens/create_new_password_screen/controller/create_new_password_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/app_input_widget_two.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

import '../../const/assets_images_path.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewPasswordScreenController>(
      init: CreateNewPasswordScreenController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(AppSize.width(value: 16)),
                child: Obx(() => SingleChildScrollView(
                  child: Form(
                    key: controller.signInFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(height: AppSize.height(value: 40)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                               AssetsImagesPath.instance.homeLogo,
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
                        AppInputWidgetTwo(
                          hintText: "Password",
                          filled: true,
                          isPassWord: true,
                          maxLines: 1,
                          contentPadding: EdgeInsets.symmetric(),
                          controller: controller.passwordTextEditingController,

                        ),
                        Gap(height: 16),
                        AppInputWidgetTwo(
                          hintText: "Confirm Password",
                          filled: true,
                          maxLines: 1,
                          isPassWord: true,
                          contentPadding: EdgeInsets.symmetric(),
                          controller: controller.confirmPasswordTextEditingController,
                        ),
                        Gap(height: 16),
                        AppButton(
                          borderRadius: BorderRadius.circular(12),
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            controller.clickSignIButton();
                          },
                          title: "Continue",
                          titleSize: AppSize.width(value: 20),
                        ),
                      ],
                    ),
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
