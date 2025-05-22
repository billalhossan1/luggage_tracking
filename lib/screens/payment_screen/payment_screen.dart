import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';
import 'package:luggage_tracking/widgets/texts/text_field_with_label.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Payment"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(height: AppSize.width(value: 20)),
            AppCard(
              child: Column(
                spacing: AppSize.width(value: 16),
                children: [
                  AppImage(path: AssetsImagesPath.instance.creditCard),
                  TextFieldWithLabel(
                    lebelText: "Name",
                    hintText: "Khushi Akter",
                  ),
                  TextFieldWithLabel(
                    lebelText: "Card Number",
                    hintText: "123456789",
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFieldWithLabel(
                          lebelText: "Expired Date ",
                          hintText: "25/12/2024",
                          trailingIcon: AssetsIconsPath.instance.date,
                          inputType: TextInputType.datetime,
                        ),
                      ),
                      Gap(width: AppSize.width(value: 16)),
                      Expanded(
                        flex: 3,
                        child: TextFieldWithLabel(
                          lebelText: "CVV",
                          hintText: "25/12/2024",
                          inputType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Total",
                        fontSize: AppSize.width(value: 20),
                        fontWeight: FontWeight.w500,
                        color: AppColors.instance.black500,
                      ),
                      AppText(
                        data: "\$${20.30.toStringAsFixed(2)}",
                        fontSize: AppSize.width(value: 20),
                        fontWeight: FontWeight.w500,
                        color: AppColors.instance.black500,
                      ),
                    ],
                  ),
                  Gap(height: AppSize.width(value: 30)),
                  AppButton(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.instance.navigationScreen);
                    },
                    title: "Confirm Payment",
                    titleSize: AppSize.width(value: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
