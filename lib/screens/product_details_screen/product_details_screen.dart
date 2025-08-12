import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/cart_screen/controller/add_to_cart_controller.dart';
import 'package:luggage_tracking/screens/product_details_screen/controller/product_details_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
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
      body: GetBuilder<ProductDetailsController>(
        init: ProductDetailsController(),
        builder: (controller) {
          return Obx(() => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.productItem == null
                  ? Center(
                      child: Text("No product found"),
                    )
                  : SingleChildScrollView(
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
                                      child: AppImage(
                                        //
                                        url: controller.selectedImage.value,
                                        // width: AppSize.width(value: 189),
                                        height: AppSize.width(value: 300),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.images.length,
                                      itemBuilder: (context, index) {
                                        var img = controller.images[index];
                                        bool isSelected = img.toLowerCase() ==
                                            controller.selectedImage.value
                                                .toLowerCase();
                                        return InkWell(
                                          onTap: () {
                                            controller.selectedImage.value =
                                                img;

                                            // controller.selectImage(img)
                                            controller.update();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(12),
                                            margin: EdgeInsets.only(
                                              right: AppSize.width(value: 4),
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: isSelected
                                                    ? Colors.purple
                                                    : Colors.transparent,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                AppSize.width(value: 8),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                AppSize.width(value: 8),
                                              ),

                                              // child: AppImage(
                                              //   url: img,
                                              //   width: AppSize.width(value: 78),
                                              //   height: AppSize.width(value: 78),
                                              //   fit: BoxFit.cover,
                                              // ),
                                              child: AppImage(
                                                url: img,
                                                width: AppSize.width(value: 40),
                                                height:
                                                    AppSize.width(value: 40),
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
                                  data: controller.productItem?.name ?? '',
                                  fontSize: AppSize.width(value: 21),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.instance.black400,
                                ),
                                AppText(
                                  data:
                                      controller.productItem?.category?.name ??
                                          '',
                                  fontSize: AppSize.width(value: 14),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.instance.black200,
                                ),
                                Row(
                                  children: [
                                    AppText(
                                      data:
                                          "\$${controller.productItem?.price?.toStringAsFixed(2)}",
                                      fontSize: AppSize.width(value: 18),
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.instance.black500,
                                    ),
                                    Gap(width: AppSize.width(value: 6)),
                                    // Text(
                                    //   '\$2000.30',
                                    //   style: TextStyle(
                                    //     fontSize: AppSize.width(value: 14),
                                    //     color: AppColors.instance.red1,
                                    //     fontWeight: FontWeight.w400,
                                    //     fontFamily: AppConst.fontFamily1,
                                    //     decoration: TextDecoration.lineThrough,
                                    //     decorationColor:
                                    //         AppColors.instance.red1,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AppText(data: "Color:"),
                                    Gap(width: AppSize.width(value: 8)),
                                    // Container(
                                    //   width: AppSize.width(value: 22),
                                    //   height: AppSize.width(value: 22),
                                    //   decoration: BoxDecoration(
                                    //     color: AppColors.instance.black900,
                                    //     shape: BoxShape.circle,
                                    //   ),
                                    // ),
                                    AppText(
                                        data: controller.productItem?.color ??
                                            'none'),
                                  ],
                                ),
                                TitledescriptionWidget(
                                    title: 'Description:',
                                    descreption:
                                        controller.productItem?.description ??
                                            ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
        },
      ),
      bottomNavigationBar:
          GetBuilder<ProductDetailsController>(builder: (controller) {
        return Obx(() => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.productItem == null
                ? SizedBox()
                : Column(
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
                                child: Obx(() => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: controller.decrementQuantity,
                                          child: Icon(
                                            Icons.remove,
                                            size: AppSize.width(value: 22),
                                            color:
                                                AppColors.instance.purple_500,
                                          ),
                                        ),
                                        AppText(
                                          data: controller.quantity.value
                                              .toString(),
                                          fontSize: AppSize.width(value: 20),
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.instance.purple_500,
                                        ),
                                        GestureDetector(
                                          onTap: controller.incrementQuantity,
                                          child: Icon(
                                            Icons.add,
                                            size: AppSize.width(value: 22),
                                            color:
                                                AppColors.instance.purple_500,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Gap(width: AppSize.width(value: 8)),
                            GetBuilder<AddToCartController>(
                                builder: (addToCartCon) {
                              return Expanded(
                                  child: Obx(
                                () => AppButton(
                                  isLoading: addToCartCon.isLoading.value,
                                  title: "Add to Cart",
                                  onTap: () {
                                    addToCartCon.addToCart(
                                        quantity: controller.quantity.value,
                                        productId:
                                            controller.productItem!.sId!);
                                  },
                                ),
                              ));
                            }),

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppButton(
                          isLoading: controller.isLoading.value,
                          filColor: Colors.transparent,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff8F00FF)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          onTap: (){
                            Get.toNamed(AppRoutes.instance.navigationScreen);
                          },
                          titleColor: Color(0xff8F00FF),
                          title: "Continue Shopping",
                          titleSize: AppSize.width(value: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppButton(
                          onTap: (){
                            Get.toNamed(AppRoutes.instance.deliveryDetainScreen,arguments: {'products':controller.makeOrder,'totalQuantity':controller.quantity.value,'totalPrice':((controller.productPrice)*(controller.quantity.value)),"details":'details'});
                          },
                          isLoading: controller.isLoading.value,
                          borderRadius: BorderRadius.circular(12),
                          title: "Confirm Order",
                          titleSize: AppSize.width(value: 20),
                        ),
                      ),
                    ],
                  ));
      }),
    );
  }
}
