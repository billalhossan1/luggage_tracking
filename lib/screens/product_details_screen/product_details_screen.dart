import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/customer_event_info_screen/controller/customer_event_info_screen.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/cards/title_descreption_widget.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String category = Get.arguments;

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Products Details"),
      body: GetBuilder<CustomerEventInfoController>(
        init: CustomerEventInfoController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: AppSize.width(value: double.infinity),
                  height: AppSize.width(value: 300),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(
                            controller.selectedImage,
                            width: AppSize.width(value: 189),
                            height: AppSize.width(value: 300),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: controller.images.length,
                            itemBuilder: (context, index) {
                              final img = controller.images[index];
                              return GestureDetector(
                                onTap: () => controller.selectImage(img),
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(
                                    right: AppSize.width(value: 4),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          controller.selectedImage == img
                                              ? Colors.transparent
                                              : Colors.transparent,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppSize.width(value: 8),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      AppSize.width(value: 8),
                                    ),

                                    // child: AppImage(
                                    //   url: img,
                                    //   width: AppSize.width(value: 78),
                                    //   height: AppSize.width(value: 78),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    child: Image.asset(
                                      img,
                                      width: AppSize.width(value: 40),
                                      height: AppSize.width(value: 40),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(16),
                  width: AppSize.width(value: double.infinity),
                  decoration: BoxDecoration(
                    color: AppColors.instance.white50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSize.width(value: 10),
                    children: [
                      AppText(
                        data: "Trkil Tracker",
                        fontSize: AppSize.width(value: 21),
                        fontWeight: FontWeight.w600,
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
                            data: "\$${16.30.toStringAsFixed(2)}",
                            fontSize: AppSize.width(value: 18),
                            fontWeight: FontWeight.w500,
                            color: AppColors.instance.black500,
                          ),

                          Gap(width: AppSize.width(value: 6)),
                          Text(
                            '\$20.30',
                            style: TextStyle(
                              fontSize: AppSize.width(value: 14),
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
                          AppText(data: "Color:"),
                          Gap(width: AppSize.width(value: 8)),
                          Container(
                            width: AppSize.width(value: 22),
                            height: AppSize.width(value: 22),
                            decoration: BoxDecoration(
                              color: AppColors.instance.black900,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),

                      TitledescriptionWidget(
                        title: 'Overview:',
                        descreption:
                            """Protect the AirTag that’s keeping track of all your important things. The OtterBox Rugged Case for AirTag securely covers the AirTag that’s attached to your keys and your pack. It buffers AirTag from all that bouncing and banging around as you go about your day. Simply twist on the case and AirTag is locked into legendary OtterBox protection and ready for anything.
                  """,
                      ),
                      TitledescriptionWidget(
                        title: "Highlights:",
                        descreption:
                            """Secure, twist-top design\nDual-material, rugged protection\nIncludes two carabiners\nLimited lifetime warranty supported by hassle-free\ncustomer service""",
                      ),
                      TitledescriptionWidget(
                        title: "Tech Specs:",
                        descreption:
                            """Form Factor: Hard Case\nMaterial: Hard Plastic, Silicone\nHeight: 2 in. / 5.1 cm\nLength: 1.6 in. / 4.1 cm\nWidth: .4 in. / 1 cm\nWeight: 0.2 oz. / 6.3 g""",
                      ),
                    ],
                  ),
                ),

               
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(height: AppSize.width(value: 8)),
          Container(
            padding: EdgeInsets.all(12),
            width: AppSize.width(value: double.infinity),
            decoration: BoxDecoration(
              color: AppColors.instance.white50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.width(value: 10),
                      horizontal: AppSize.width(value: 6),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.instance.purple_500,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.remove,
                          size: AppSize.width(value: 22),
                          color: AppColors.instance.purple_500,
                        ),
                        AppText(
                          data: "0",
                          fontSize: AppSize.width(value: 20),
                          fontWeight: FontWeight.w400,
                          color: AppColors.instance.purple_500,
                        ),
                        Icon(
                          Icons.add,
                          size: AppSize.width(value: 22),
                          color: AppColors.instance.purple_500,
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(width: AppSize.width(value: 8)),
                Expanded(
                  child: AppButton(
                    title: "Buy Now",
                    onTap: () {
                      Get.toNamed(AppRoutes.instance.deliveryDetainScreen);
                    },
                  ),
                ),
              ],
            ),
          ),
          Gap(height: AppSize.width(value: AppSize.width(value: 26))),
        ],
      ),
    );
  }
}
