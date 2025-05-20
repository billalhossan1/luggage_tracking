import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/app_input_widget.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ChnagePasswordScreen extends StatelessWidget {
  const ChnagePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change Password"),
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
                  "Your new password must be different from previous passwords.",
            ),
            AppInputWidget(
              hintText: "",
              title: 'Old Password',
              inImpotant: false,
            ),
            AppInputWidget(
              hintText: "",
              title: 'New Password',
              inImpotant: false,
            ),
            AppInputWidget(
              hintText: "",
              title: 'Confirm Password',
              inImpotant: false,
            ),
            Gap(height: AppSize.width(value: 30)),
            AppButton(
              title: "Confirm",
              titleColor: AppColors.instance.white50,
              titleSize: AppSize.width(value: 18),
              borderRadius: BorderRadius.circular(16),
            ),
          ],
        ),
      ),
    );
  }
}
