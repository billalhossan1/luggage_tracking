import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/screens/delivery_details_screen/controller/delivery_details_screen_controller.dart';
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
    return GetBuilder<DeliveryDetailsScreenController>(
      init: DeliveryDetailsScreenController(),
      builder: (controller) {
        return Form(
          key: controller.formKey,
          child: Scaffold(
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

                    AppInputWidget(
                      title: "Contact No",
                      hintText: "+963 xxx xxx xxx",
                      controller: controller.contactTEController,
                    ),
                    AppInputWidget(
                      isEmail: true,
                      title: "Email",
                      hintText: "example@gmail.com",
                      controller: controller.emailTEController,
                    ),
                    AppInputWidget(
                      title: "zip code",
                      hintText: "1234",
                      controller: controller.zipCodeTEController,
                    ),AppInputWidget(
                      title: "city",
                      hintText: "Damascus",
                      controller: controller.cityTEController,
                    ),AppInputWidget(
                      title: "Street",
                      hintText: "123, Main Street",
                      controller: controller.streetTEController,
                    ),AppInputWidget(
                      title: "Address",
                      hintText: "P. O. Box 50332, Damasc...",
                      controller: controller.addressTEController,
                    ),
                    AddDescripsion(title: "Note (Optional)",controller: controller.noteTEController,validatior: false,),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.width(value: 10),
                  vertical: AppSize.width(value: 20),
                ),
                child: AppButton(
                  title: "Continue",
                  titleSize: 20,
                  onTap: () {
                   controller.onTapContinue();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
