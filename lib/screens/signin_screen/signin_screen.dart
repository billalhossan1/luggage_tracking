import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/signin_screen/controller/sign_in_screen_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/button/btn_icon_text.dart';
import 'package:luggage_tracking/widgets/texts/app_input_widget_two.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
              child: Obx(() => Column(
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
                      Gap(height: 8,),
                      AppText(
                        data: "Welcome Back !",
                        color: AppColors.instance.black900,
                        fontSize: AppSize.width(value: 24),
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(height: 8,),
                      AppText(
                        data: "Please Enter Your Email & Password",
                        color: AppColors.instance.white700,
                        fontSize: AppSize.width(value: 16),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: AppColors.instance.green1,
                                  ),
                                  child: Checkbox(
                                    activeColor: AppColors.instance.white200,
                                    visualDensity: const VisualDensity(
                                      horizontal: -4,
                                      vertical: -4,
                                    ),
                                    side: MaterialStateBorderSide.resolveWith(
                                          (states) {
                                        if (states.contains(MaterialState.selected)) {
                                          return BorderSide(color: AppColors.instance.white600);
                                        } else {
                                          return BorderSide(color: AppColors.instance.white600);
                                        }
                                      },
                                    ),
                                    value: controller.isRememberMe.value,
                                    checkColor: AppColors.instance.purple_500,
                                    fillColor: MaterialStateProperty.all(AppColors.instance.white200),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(AppSize.width(value: 5.0)),
                                    ),
                                    onChanged: (_) {
                                      controller.onToggleRememberMe();
                                    },
                                  ),
                                ),
                                AppText(
                                  data: "Remember me",
                                  color: AppColors.instance.black200,
                                  fontSize: AppSize.width(value: 12),
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.instance.forgetPasswordScreen);
                              },
                              child: AppText(
                                data: "Forgot Password?",
                                color: AppColors.instance.blue1,
                                fontSize: AppSize.width(value: 12),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Gap(height: 24),
                        AppButton(
                          borderRadius: BorderRadius.circular(12),
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            controller.clickSignIButton();
                          },
                          title: "Sign In",
                          titleSize: AppSize.width(value: 20),
                        ),
                        Gap(height: AppSize.width(value: 40)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                            Gap(width: AppSize.width(value: 8)),
                            AppText(data: "Or"),
                            Gap(width: AppSize.width(value: 8)),
                            Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                          ],
                        ),
                        Gap(height: AppSize.width(value: 40)),
                        BtnIconText(
                          onTap: () {
                          controller.googleLogin();
                          },
                          paddingvert: AppSize.width(value: 16),
                          text: "Google",
                          iconPath: AssetsIconsPath.instance.google,
                        ),
                      ],
                    ),
                  ),
                  Gap(height: AppSize.width(value: 16)),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Have no account? ',
                        style: TextStyle(
                          color: AppColors.instance.black200,
                          fontFamily: AppConst.fontFamily1,
                          fontSize: AppSize.width(value: 14),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Registration',
                            style: TextStyle(
                              color: AppColors.instance.blue1,
                              fontFamily: AppConst.fontFamily1,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed(AppRoutes.instance.signUp);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
        );
      },
    );
  }
}
