import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ProductCard extends StatefulWidget {
  final Function()? onTap;
  final bool isBookmark;       // initial bookmark state
  final bool isToggleable;     // controls if user can toggle

  const ProductCard({
    super.key,
    this.onTap,
    required this.isBookmark,
    this.isToggleable = true,  // default true (toggle enabled)
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.isBookmark;
  }

  void toggleBookmark() {
    if (widget.isToggleable) {
      setState(() {
        isBookmarked = !isBookmarked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
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
                      onTap: toggleBookmark,
                      child: AppImage(
                        path: isBookmarked
                            ? AssetsIconsPath.instance.isFavorate
                            : AssetsIconsPath.instance.favorate,
                        width: AppSize.width(value: 18),
                        height: AppSize.width(value: 18),
                      ),
                    ),
                  ],
                ),
                AppImage(
                  path: AssetsImagesPath.instance.product2,
                  fit: BoxFit.cover,
                  width: AppSize.width(value: 115),
                  height: AppSize.width(value: 115),
                ),
              ],
            ),
            Gap(height: AppSize.width(value: 16)),
            AppText(
              data: "Luggage Tag",
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
                      data: "Trkil",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.black200,
                    ),
                    Gap(height: AppSize.width(value: 8)),
                    AppText(
                      data: "\$${3.00}",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w600,
                      color: AppColors.instance.black400,
                    ),
                  ],
                ),
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
      ),
    );
  }
}
