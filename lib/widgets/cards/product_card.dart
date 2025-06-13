import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ProductCard extends StatelessWidget {

  final ProductItem? productItem; // Optional product data
  final bool isBookmarked; // Track the bookmark state
  final Function() onBookmarkToggle; // Callback to toggle the bookmark state
  final HomeScreenController controller;
  // VoidCallback onBookmarkToggle; // Callback to toggle the bookmark state
  const ProductCard({
    super.key,
    this.productItem,
    required this.isBookmarked,
    required this.onBookmarkToggle, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutes.instance.productDetailsScreen,arguments: {
          "product": productItem
        });
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            width: AppSize.width(value: 163),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.instance.white500,
                width: .5,
              ),
              color: AppColors.instance.white50,
              borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImage(
                  url: Urls.imageBaseUrl + (productItem?.images?.first ?? ""),
                  fit: BoxFit.cover,
                  width: AppSize.width(value: 115),
                  height: AppSize.width(value: 115),
                ),
                Gap(height: AppSize.width(value: 16)),
                AppText(
                  data: productItem?.name ?? "Luggage Tag", // Replace with actual field
                  fontSize: AppSize.width(value: 14),
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.black400,
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          data: productItem?.category?.name ?? "Brand", // Replace with actual field
                          fontSize: AppSize.width(value: 12),
                          fontWeight: FontWeight.w400,
                          color: AppColors.instance.black200,
                        ),
                        Gap(height: AppSize.width(value: 8)),
                        AppText(
                          data: "\$${productItem?.price ?? 0.0}",
                          fontSize: AppSize.width(value: 14),
                          fontWeight: FontWeight.w600,
                          color: AppColors.instance.black400,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.instance.deliveryDetainScreen,arguments: {"product":productItem});
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.instance.white500,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          size: AppSize.width(value: 18),
                          color: AppColors.instance.purple_500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child:     Obx(()=>Visibility(
                visible: !controller.bookMarkLoading.value,
                replacement: Center(child: CircularProgressIndicator(),),
                child: GestureDetector(
                  onTap: onBookmarkToggle, // Call the parent callback to toggle bookmark
                  child: isBookmarked ? Icon(Icons.favorite,color: Color(0xff8F00FF),): Icon(Icons.favorite_border_outlined,color: Color(0xff8F00FF),),
                  // child: AppImage(
                  //   path: isBookmarked
                  //       ? AssetsIconsPath.instance.isFavorate
                  //       : AssetsIconsPath.instance.favorate,
                  //   width: AppSize.width(value: 18),
                  //   height: AppSize.width(value: 18),
                  // ),
                ),
              ),))
        ],
      ),
    );
  }
}
