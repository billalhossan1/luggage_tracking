import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/screens/delete_account_screen/controller/delete_account_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/app_input_widget.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class DeteleAccountScreen extends StatelessWidget {
  const DeteleAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteAccountController>(
      init: DeleteAccountController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: "Delete Account"),
          body: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 16)),
            child: Column(
              children: [
                Gap(height: AppSize.width(value: 12)),
                AppText(
                  fontSize: AppSize.width(value: 14),
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.black200,
                  data:
                      "Pleas confirm your password  to verification and remove your account.",
                ),
                AppInputWidget(
                  hintText: "",
                  title: 'Password',
                  inImpotant: false,
                  controller: controller.passwordTEController,
                ),

                Gap(height: AppSize.width(value: 30)),
                Obx(
                  () => Visibility(
                    visible: !controller.inProgress.value,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: AppButton(
                      onTap: controller.deleteAccount,
                      title: "Confirm",
                      titleColor: AppColors.instance.white50,
                      titleSize: AppSize.width(value: 18),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
