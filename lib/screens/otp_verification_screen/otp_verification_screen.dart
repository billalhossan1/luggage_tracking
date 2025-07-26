import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/screens/otp_verification_screen/controllers/otp_verification_screen_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  void initState() {
    Get.find<OtpVerificationScreenController>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<OtpVerificationScreenController>(
      init: OtpVerificationScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.instance.white50,
          appBar: CustomAppBar(title: ""),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.width(value: 16),
                vertical: AppSize.width(value: 100),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  AppImage(
                    path: AssetsIconsPath.instance.appLogoCircle,
                    width: screenWidth * 0.12,
                    height: screenWidth * 0.12,
                  ),
                  const SizedBox(height: 20),
                  AppText(
                    data: "Enter 6 digits code",
                    color: AppColors.instance.black900,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10),
                  AppText(
                    data: "Enter the six-digit code that was emailed to you.",
                    color: AppColors.instance.white700,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                  // SizedBox(height: screenHeight * 0.05),
                  Form(
                    key: controller.verificationCodeKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Obx(
                        //   () =>
                        //       controller.isEmailVerification.value
                        //           ? AppText(
                        //             data: controller.argMail.value,
                        //             fontWeight: FontWeight.w500,
                        //             color: AppColors.instance.purple_500,
                        //           )
                        //           : const SizedBox(),
                        // ),
                        const SizedBox(height: 40),
                        Obx(
                          () => TextFormField(
                            controller: controller.otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Enter your code',
                              labelStyle: TextStyle(color: Colors.black54),
                              counterText: "",
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      controller.hasError.value
                                          ? AppColors.instance.red1
                                          : AppColors.instance.black50,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      controller.hasError.value
                                          ? AppColors.instance.red1
                                          : AppColors.instance.black50,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length != 6) {
                                controller.hasError.value = true;
                                return 'Enter a valid 6-digit OTP';
                              }
                              controller.hasError.value = false;
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => Row(
                            children: [
                              AppText(data: "This code will expire in "),
                              Visibility(
                                visible: controller.seconds.value > 0,
                                child: AppText(
                                  data: controller.formatTime(
                                    controller.seconds.value,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.seconds.value == 0,
                                child: TextButton(
                                  onPressed: () {
                                    controller.onTapResend();
                                  },
                                  child: Text('Resend'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Obx(
                    () =>
                        controller.otpIsLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : AppButton(
                              title:
                                  !controller.isEmailVerification.value
                                      ? "Reset Password"
                                      : "Verify",
                              onTap: () {
                                try {
                                  controller.clickVerificationCodeButton();
                                } catch (e) {
                                  debugPrint("Navigation error: $e");
                                  Get.snackbar(
                                    "Error",
                                    "Could not navigate to next screen",
                                  );
                                }
                              },
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
