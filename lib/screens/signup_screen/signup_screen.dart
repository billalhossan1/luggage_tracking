import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/signin_screen/controller/sign_in_screen_controller.dart';
import 'package:luggage_tracking/utils/app_all_log/app_log.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/button/btn_icon_text.dart';
import 'package:luggage_tracking/widgets/texts/app_input_widget_two.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInScreenController>(
      init: SignInScreenController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.width(value: 16),
                vertical: AppSize.height(value: 32),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        data: "Registration",
                        color: AppColors.instance.black900,
                        fontSize: AppSize.width(value: 24),
                        fontWeight: FontWeight.w600,
                      ),
                      AppText(
                        data: "Create your account",
                        color: AppColors.instance.white700,
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Gap(height: AppSize.height(value: 20)),
                  Form(
                    key: controller.signInFormKey,
                    child: Column(
                      children: [
                        AppInputWidgetTwo(
                          hintText: "Name",
                          filled: true,
                          isEmail: true,
                          contentPadding: EdgeInsets.symmetric(),
                          controller: controller.emailTextEditingController,
                        ),
                        Gap(height: 30),
                        AppInputWidgetTwo(
                          hintText: "Contact No",

                          filled: true,
                          isPassWord: true,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          contentPadding: EdgeInsets.symmetric(),
                          controller: controller.passwordTextEditingController,
                        ),
                        Gap(height: 16),
                        AppInputWidgetTwo(
                          hintText: "Email",
                          filled: true,
                          isEmail: true,
                          contentPadding: EdgeInsets.symmetric(),
                          controller: controller.emailTextEditingController,
                        ),
                        Gap(height: 30),
                        AppInputWidgetTwo(
                          hintText: "Password",

                          filled: true,
                          isPassWord: true,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          contentPadding: EdgeInsets.symmetric(),
                          controller: controller.passwordTextEditingController,
                        ),
                        Gap(height: 16),
                        AppInputWidgetTwo(
                          hintText: "Password",

                          filled: true,
                          isPassWord: true,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          contentPadding: EdgeInsets.symmetric(),
                          controller: controller.passwordTextEditingController,
                        ),
                        Gap(height: 24),
                        AppButton(
                          borderRadius: BorderRadius.circular(12),
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            // controller.signInUser();
                          },
                          title: "Sign In",
                          titleSize: AppSize.width(value: 20),
                        ),
                        Gap(height: AppSize.width(value: 30)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(color: Colors.grey, thickness: 1),
                            ),
                            Gap(width: AppSize.width(value: 8)),
                            AppText(data: "Or"),
                            Gap(width: AppSize.width(value: 8)),
                            Expanded(
                              child: Divider(color: Colors.grey, thickness: 1),
                            ),
                          ],
                        ),
                        Gap(height: AppSize.width(value: 30)),
                        Row(
                          children: [
                            Expanded(
                              child: BtnIconText(
                                onTap: () {
                                  appLog(
                                    "==============>>>>>Google BTN Clicked<<<<=================",
                                  );
                                },
                                paddingvert: AppSize.width(value: 16),
                                text: "Google",
                                iconPath: AssetsIconsPath.instance.google,
                              ),
                            ),
                            Gap(width: AppSize.width(value: 12)),
                            Expanded(
                              child: BtnIconText(
                                onTap: () {
                                  appLog(
                                    "==============>>>>>Facebook BTN Clicked<<<<=================",
                                  );
                                },
                                paddingvert: AppSize.width(value: 16),
                                text: "Facebook",
                                iconPath: AssetsIconsPath.instance.fb,
                                filColor: AppColors.instance.blue1,
                                textColor: AppColors.instance.white50,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(height: AppSize.width(value: 30)),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: AppColors.instance.black200,
                          fontFamily: AppConst.fontFamily1,
                          fontSize: AppSize.width(value: 14),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppColors.instance.blue1,
                              fontFamily: AppConst.fontFamily1,

                              fontWeight: FontWeight.w500,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    // Tap handle logic here
                                    Get.back();
                                    // Navigator.push(...); // optionally navigate to another page
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
