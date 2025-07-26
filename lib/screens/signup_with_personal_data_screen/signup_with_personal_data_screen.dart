import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/screens/signup_with_personal_data_screen/controller/signup_with_personal_data_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
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
          child: GetBuilder<SignupWithPersonalDataController>(
            init: SignupWithPersonalDataController(),
            builder: (controller) {
              return Form(
                key: controller.personalDataFormKey,
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

                    CustomTextField.build(hintText: "Contact No",controller: controller.contactNumberTextEditingController,),
                    CustomTextField.build(hintText: "Date of Birth",controller: controller.dateOfBirthTextEditingController),
                    CustomTextField.build(hintText: "Gender",controller: controller.genderTextEditingController),
                    CustomTextField.build(hintText: "Occupation",controller: controller.occupationTextEditingController),
                    // Obx(()=>AppDropDown<String>(
                    //   hintText: "Country",
                    //   items: controller.countryList,
                    //   value: controller.selectedCountry.value,
                    //   onChanged: (value) {
                    //     if (value != null) {
                    //       controller.selectedCountry.value = value;
                    //       // Logger().i("Selected Country: ${controller.selectedCountry.value}");
                    //     }
                    //   }, selectedValue: '',
                    // ),
                    // ),
                    // AppDropDown(hintText: "City", items: cityList,value: controller.selectedCity.value,
                    //   onChanged: (value) {
                    //     if (value != null) {
                    //       controller.selectedCity.value = value;
                    //       // Logger().i("Selected City: ${controller.selectedCity.value}");
                    //     }
                    //   },
                    // ),
                    CustomTextField.build(hintText: "Address"),
                    Gap(height: AppSize.width(value: 36)),
                    AppButton(
                      onTap: () {
                        controller.onTapNext();
                        // Get.toNamed(AppRoutes.instance.subPlanScreen);
                      },
                      title: "Continue",
                      titleSize: AppSize.width(value: 20),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
