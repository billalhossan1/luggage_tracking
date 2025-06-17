import 'package:flutter/material.dart';
import 'package:luggage_tracking/screens/edit_profile_screen/controler/edit_profile_controller.dart';
import 'package:luggage_tracking/const/app_colors.dart'; // Import the app colors if needed

class DatePickerTextField extends StatelessWidget {
  final EditProfileController controller;

  const DatePickerTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.dateOfBirthTEController,
      keyboardType: TextInputType.datetime,
      readOnly: true, // Make the field readonly so users can only select a date or type it
      decoration: InputDecoration(
        labelText: 'Pick a Date',
        labelStyle: TextStyle(color: AppColors.instance.black400), // Match the CustomTextField label style
        fillColor: Colors.white, // You can set a background color here if you need
        filled: true, // Set to true to apply fill color
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.instance.white600),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.instance.white600),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            // Open the date picker when the calendar icon is tapped
            controller.openDatePicker(context);
          },
        ),
      ),
      onTap: () {
        // Hide the keyboard and show the date picker when tapping on the field
        FocusScope.of(context).requestFocus(FocusNode()); // Hide keyboard
        controller.openDatePicker(context);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a date';
        }
        return null;
      },
    );
  }
}
