import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: AppSize.width(value: 12),
            children: [
              CustomTextField.build(hintText: "User Name"),
              CustomTextField.build(hintText: "Email"),
              CustomTextField.build(hintText: "Contact No"),
              CustomTextField.build(hintText: "Date of Birth"),
              CustomTextField.build(hintText: "Gender"),
              CustomTextField.build(hintText: "Occupation"),
              AppDropDown(hintText: "Country", items: countryList),
              AppDropDown(hintText: "City", items: cityList),
              CustomTextField.build(hintText: "Address"),
              CheckBoxWithText(),
              Gap(height: AppSize.width(value: 12)),
              AppButton(
                title: "Save & Change",
                titleSize: AppSize.width(value: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<String> countryList = [
  'Bangladesh',
  'India',
  'United States',
  'Canada',
  'Australia',
];
final List<String> cityList = [
  'New York',
  'London',
  'Tokyo',
  'Paris',
  'Sydney',
  'Toronto',
  'Dubai',
  'Singapore',
  'Los Angeles',
  'Mumbai',
];
