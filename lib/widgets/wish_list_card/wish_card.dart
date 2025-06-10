import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';
import 'package:luggage_tracking/screens/wish_list_screen/model/wish_list_model.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class WishCard extends StatelessWidget {
  final RxBool bookMarkLoading;
  final String name;
  final String imageUrl;
  final String description;
  final int price;
  final Function() onBookmarkToggle; // Callback to toggle the bookmark state
  // VoidCallback onBookmarkToggle; // Callback to toggle the bookmark state
  const WishCard({
    super.key,

    required this.onBookmarkToggle, required this.name, required this.imageUrl, required this.description, required this.price,required this.bookMarkLoading
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: AppSize.width(value: 18),
                    height: AppSize.width(value: 18),
                    decoration: BoxDecoration(
                      color: AppColors.instance.white200,
                      shape: BoxShape.circle,
                    ),
                  ),
                  GestureDetector(
                    onTap: onBookmarkToggle, // Call the parent callback to toggle bookmark
                    child:Visibility(visible:!bookMarkLoading.value,replacement:Center(child: CircularProgressIndicator(),),child: Icon(Icons.favorite,color: Color(0xff8F00FF),))
                    // child: AppImage(
                    //   path: isBookmarked
                    //       ? AssetsIconsPath.instance.isFavorate
                    //       : AssetsIconsPath.instance.favorate,
                    //   width: AppSize.width(value: 18),
                    //   height: AppSize.width(value: 18),
                    // ),
                  ),
                ],
              ),
              AppImage(
                url: Urls.imageBaseUrl + (imageUrl),
                fit: BoxFit.cover,
                width: AppSize.width(value: 115),
                height: AppSize.width(value: 115),
              ),
            ],
          ),
          Gap(height: AppSize.width(value: 16)),
          AppText(
            data: name,
            fontSize: AppSize.width(value: 14),
            fontWeight: FontWeight.w400,
            color: AppColors.instance.black400,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(height: AppSize.width(value: 8)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: description,
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.black200,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(height: AppSize.width(value: 8)),
                    AppText(
                      data: "\$$price",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w600,
                      color: AppColors.instance.black400,
                    ),
                  ],
                ),
              ),
              Gap(width: 8),
              Container(
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
            ],
          ),
        ],
      ),
    );
  }
}
