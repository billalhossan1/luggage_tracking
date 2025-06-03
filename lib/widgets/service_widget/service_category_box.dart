import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

import '../../screens/home_screen/model/category_list_model.dart';

class ServiceCategoryBox extends StatelessWidget {
  const ServiceCategoryBox({super.key, required this.category});
  final CategoryItem category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.instance.productCategoryScreen,
        );
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: AppSize.width(value: 12)),
        padding: EdgeInsets.all(AppSize.width(value: 8)),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.instance.white500,
            width: 0.5,
          ),
          color: AppColors.instance.white50,
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
        // Wrap Column in fixed height SizedBox to constrain height
        child: SizedBox(
          height: AppSize.height(value: 92), // same fixed height as your ListView item height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage(
                url: category.image ?? "",
                height: AppSize.height(value: 47),
                width: AppSize.width(value: 51),
              ),
              const Gap(height: 10),
              AppText(
                data: category.name ?? "",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.instance.black200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
