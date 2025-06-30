import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/delivery_details_screen/controller/delivery_details_screen_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/divider/app_divider.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';
import 'package:luggage_tracking/widgets/texts/text_card_headline.dart';
import 'package:luggage_tracking/widgets/texts/text_row_item.dart';

import 'controller/delivary_details_show_screen_controller.dart';

class DeliveryDetailsShowScreen extends StatelessWidget {
  const DeliveryDetailsShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryDetailsShowScreenController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: "Delivery Details"),
          body: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child:Column(
              spacing: AppSize.width(value: 10),
              children: [
                ///Contact Details
                AppCard(
                  child: Column(
                    spacing: AppSize.width(value: 12),
                    children: [
                      TextForCardHeadLine(text: "Contact Details"),

                      Gap(height: AppSize.width(value: 2)),
                      TextRowItem(text1: "Contact No", text2: controller.contact??'no contact given'),
                      TextRowItem(
                        text1: "Email",
                        text2: controller.email??'no email given',
                      ),
                      TextRowItem(
                        text1: "Address",
                        text2: controller.address??'no address given',
                      ),
                      TextRowItem(text1: "Note", text2: controller.note??'no note given',),
                    ],
                  ),
                ),

                ///Product Information
                AppCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: AppSize.width(value: 10),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            data: "Trkil Tracker",
                            fontSize: AppSize.width(value: 16),
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.black400,
                          ),
                          AppText(
                            data: "Trkil",
                            fontSize: AppSize.width(value: 14),
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.black200,
                          ),
                          Row(
                            children: [
                              AppText(
                                data: "\$${controller.product?.price?.toStringAsFixed(2)?? 0}",
                                fontSize: AppSize.width(value: 14),
                                fontWeight: FontWeight.w500,
                                color: AppColors.instance.black500,
                              ),

                              Gap(width: AppSize.width(value: 6)),
                              Text(
                                '\$20.30',
                                style: TextStyle(
                                  fontSize: AppSize.width(value: 12),
                                  color: AppColors.instance.red1,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppConst.fontFamily1,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.instance.red1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AppText(data: "Color:  ${controller.product?.color??''}"),
                              Gap(width: AppSize.width(value: 10)),
                              // Container(
                              //   width: AppSize.width(value: 20),
                              //   height: AppSize.width(value: 20),
                              //   decoration: BoxDecoration(
                              //     color: AppColors.instance.black900,
                              //     shape: BoxShape.circle,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      AppImage(
                        path: AssetsImagesPath.instance.product1,
                        width: AppSize.width(value: 84),
                        height: AppSize.width(value: 100),
                      ),
                    ],
                  ),
                ),

                ///Payment Summary
                AppCard(
                  child: Column(
                    children: [
                      TextForCardHeadLine(text: "Payment Summary"),
                      Gap(height: AppSize.width(value: 16)),

                      TextRowItem(text1: "Product Quantity", text2: "${controller.quantity}"),
                      AppDivider(),
                      TextRowItem(
                        text1: "Subtotal",
                        text2: "\$${((controller.product?.price ?? 0) * (controller.quantity ?? 0)).toStringAsFixed(2)}",
                      ),

                      Gap(height: AppSize.width(value: 14)),
                      TextRowItem(
                        text1: "Delivery Charge",
                        text2: "\$${4.30.toStringAsFixed(2)}",
                      ),
                      AppDivider(),
                      TextRowItem(
                        text1: "Total",
                        text2: "\$${(((controller.product?.price ?? 0) * (controller.quantity ?? 0))+4.30).toStringAsFixed(2)}",
                        text2Color: AppColors.instance.green1,
                      ),
                    ],
                  ),
                ),
                Gap(height: AppSize.width(value: 44)),
                Obx(()=>controller.isLoading.value? Center(child: CircularProgressIndicator(),):AppButton(
                  title: "Continue",
                  titleSize: 20,
                  onTap: () {
                    controller.onTapContinue(context);
                  },
                ),)
              ],
            ),
          ),
        );
      }
    );
  }
}
