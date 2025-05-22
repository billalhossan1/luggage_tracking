import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/edit_profile_screen/edir_profile_screen.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_drop_down/app_drop_down.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';
import 'package:luggage_tracking/widgets/texts/custom_text_field.dart';

class SignupWithPersonalDataScreen extends StatelessWidget {
  const SignupWithPersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSize.width(value: 12),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.width(value: 20),
                ),
                child: AppText(
                  data: "Please Enter Your Personal Data",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.black300,
                ),
              ),

              CustomTextField.build(hintText: "Contact No"),
              CustomTextField.build(hintText: "Date of Birth"),
              CustomTextField.build(hintText: "Gender"),
              CustomTextField.build(hintText: "Occupation"),
              AppDropDown(hintText: "Country", items: countryList),
              AppDropDown(hintText: "City", items: cityList),
              CustomTextField.build(hintText: "Address"),
              Gap(height: AppSize.width(value: 36)),
              AppButton(
                onTap: () {
                  Get.toNamed(AppRoutes.instance.subPlanScreen);
                },
                title: "Continue",
                titleSize: AppSize.width(value: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
