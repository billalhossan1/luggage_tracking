import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/short_text_date.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/cart_screen/controller/cart_controller.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/cart_item_widget/cart_item_widget.dart';

import '../../const/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_size.dart';
import '../../widgets/appbar/custom_appbar.dart';
import '../../widgets/button/app_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find<CartController>();
    return Scaffold(
      appBar: CustomAppBar(title: "My Cart"),
      body: Column(
        children: [
          Obx(() => Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.cartList.isEmpty
                  ? Center(child: Text("Cart is Empty"))
                  : ListView.builder(
                itemCount: controller.cartList.length,
                itemBuilder: (context, index) => GetBuilder<CartController>(
                    builder: (context) {
                      if(index==0){
                        controller.totalPrice=0;
                        controller.totalQuantity=0;
                      }
                      var price = (controller.cartList[index].quantity ?? 0) * (controller.cartList[index].product?.price ?? 0);
                      controller.totalQuantity+=controller.cartList[index].quantity ?? 0;
                      controller.totalPrice+=price;
                      return CartItemWidget(
                        color: controller.cartList[index].product?.color ?? '',
                        category: controller.cartList[index].product?.category?.name ?? '',
                        name: ShortText.getShortText(controller.cartList[index].product?.name ?? '', maxLength: 16),
                        price: ((controller.cartList[index].quantity)! * (controller.cartList[index].product?.price ?? 0)),
                        quantity: controller.cartList[index].quantity ?? 1,
                        onDelete: () {
                          controller.onTapDelete(controller.cartList[index].sId ?? '');
                        },
                        onIncrement: () {
                          controller.cartList[index].quantity = controller.cartList[index].quantity! + 1;
                          controller.update();
                          controller.increaseApiCall(controller.cartList[index].sId ?? '');
                        },
                        onDecrement: () {
                          controller.cartList[index].quantity = controller.cartList[index].quantity! - 1;
                          controller.update();
                          controller.decreaseApiCall(controller.cartList[index].sId ?? '');
                        },
                        image: "${Urls.imageBaseUrl}${controller.cartList[index].product?.images?[0] ?? ''}",
                      );
                    }
                ),
              ),
            ),
          )),
          Obx(()=>Visibility(
            visible: !controller.isLoading.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(
                filColor: Colors.transparent,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff8F00FF)),
                  borderRadius: BorderRadius.circular(12),
                ),
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Get.toNamed(AppRoutes.instance.navigationScreen);
                },
                titleColor: Color(0xff8F00FF),
                title: "Continue Shopping",
                titleSize: AppSize.width(value: 20),
              ),
            ),
          ),),
          Obx(()=>Visibility(
            visible: !controller.isLoading.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Get.toNamed(AppRoutes.instance.deliveryDetainScreen,arguments: {"products":controller.cartList,"totalQuantity":controller.totalQuantity,"totalPrice":controller.totalPrice,});
                },
                title: "Confirm Order",
                titleSize: AppSize.width(value: 20),
              ),
            ),
          ),),
          Gap(height: 20,)
        ],
      ),
    );
  }
}

