import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/add_descrepsion.dart';
import 'package:luggage_tracking/widgets/texts/app_input_widget.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  const DeliveryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Delivery Details"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(height: AppSize.width(value: 25)),
              AppText(
                data: "Contact Details",
                fontSize: AppSize.width(value: 18),
                fontWeight: FontWeight.w500,
                color: AppColors.instance.purple_500,
              ),
              Gap(height: AppSize.width(value: 12)),
              AppText(
                data:
                    "The products will be delivered to the following address.",
                fontSize: AppSize.width(value: 14),
                fontWeight: FontWeight.w400,
                color: AppColors.instance.black200,
              ),
              Gap(height: AppSize.width(value: 12)),

              AppInputWidget(title: "Contact No", hintText: "+963 932 509 736"),
              AppInputWidget(
                title: "Email",
                hintText: "asadujjamanmahfuz@gmail.com",
              ),
              AppInputWidget(
                title: "Address (this content well show in Card)",
                hintText: "P. O. Box 50332, Damasc...",
              ),
              AddDescripsion(title: "Note (Optional)"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 10),
          vertical: AppSize.width(value: 20),
        ),
        child: AppButton(title: "Continue"),
      ),
    );
  }
}
