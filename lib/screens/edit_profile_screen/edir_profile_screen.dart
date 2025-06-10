import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/edit_profile_screen/controler/edit_profile_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_drop_down/app_drop_down.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField.build(
                      hintText: "User Name",
                      controller: controller.userNameTEController,

                    ),
                    CustomTextField.build(
                      hintText: "Email",
                      controller: controller.emailTEController,
                    ),
                    CustomTextField.build(
                      hintText: "Contact No",
                      controller: controller.contactTEController,
                    ),
                    CustomTextField.build(
                      hintText: "Date of Birth",
                      controller: controller.dateOfBirthTEController,
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
                      hintText: "Address",
                      controller: controller.addressTEController,
                    ),
                    CheckBoxWithText(controller: controller),
                    Gap(height: AppSize.width(value: 12)),
                    AppButton(
                      title: "Save & Change",
                      titleSize: AppSize.width(value: 20),
                      onTap: (){
                        controller.checkValidation();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
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
