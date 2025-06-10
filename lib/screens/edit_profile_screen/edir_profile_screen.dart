import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/edit_profile_screen/controler/edit_profile_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_drop_down/app_drop_down.dart';
import 'package:luggage_tracking/widgets/app_validation_button/app_validation_button.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/box/check_box_with_text.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/custom_text_field.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: "Edit Profile"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(  // Wrap the form fields in a Form widget
                    key: controller.formKey,  // Pass the form key here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField.build(
                          hintText: "User Name",
                          controller: controller.userNameTEController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),

                        CustomTextField.build(
                          readonly: true,
                          hintText: "Email",
                          controller: controller.emailTEController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                        CustomTextField.build(
                          hintText: "Contact No",
                          controller: controller.contactTEController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Contact No is required';
                            }
                            return null;
                          },
                        ),
                        CustomTextField.build(
                          hintText: "Date of Birth",
                          controller: controller.dateOfBirthTEController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date of Birth is required';
                            }
                            return null;
                          },
                        ),
                        AppDropDown(
                          hintText: "Gender",
                          items: gender,
                          selectedValue: controller.selectedGender.value,
                          onChanged: controller.onSelectGender,
                        ),
                        CustomTextField.build(
                          hintText: "Occupation",
                          controller: controller.occupationTEController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Occupation is required';
                            }
                            return null;
                          },
                        ),
                        AppDropDown(
                          hintText: "Country",
                          items: countryList,
                          selectedValue: controller.selectedCountry.value,
                          onChanged: controller.onSelectCountry,
                        ),
                        AppDropDown(
                          hintText: "City",
                          items: cityList,
                          selectedValue: controller.selectedCity.value,
                          onChanged: controller.onSelectCity,
                        ),
                        CustomTextField.build(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Address is required';
                            }
                            return null;
                          },
                          hintText: "Address",
                          controller: controller.addressTEController,
                        ),
                        Gap(height: AppSize.width(value: 12)),
                      ],
                    ),
                  ),
                  Gap(height: 60),
                  CheckBoxWithText(controller: controller),
                  Gap(height: 10),
                  Obx(() {
                    return Visibility(
                      visible: !controller.isLoading.value,
                      replacement: Center(child: CircularProgressIndicator(),),
                      child: AppValidationButton(
                        title: "Save & Change",
                        titleSize: AppSize.width(value: 20),
                        onTap: () {
                          controller.checkValidation();
                        },
                        isLoading: false,
                        isRememberMe: controller.isRememberMe.value,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}





final List<String> countryList = [
  'Bangladesh', 'India', 'United States', 'Canada', 'Australia',
];

final List<String> cityList = [
  'New York', 'London', 'Tokyo', 'Paris', 'Sydney', 'Toronto',
  'Dubai', 'Singapore', 'Los Angeles', 'Mumbai',
];

final List<String> gender = [
  'Male', 'Female', 'Others',
];
