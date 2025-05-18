import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ServiceCategoryBox extends StatelessWidget {
  const ServiceCategoryBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(
        //   AppRoutes.listOfViewServicesScreen,
        //   arguments: item,
        // );

        // appLog('Index: $index, Title: ${item.title}');
      },
      child: Container(
        alignment: Alignment.center, // width fixed
        margin: EdgeInsets.only(right: AppSize.width(value: 12)),
        padding: EdgeInsets.all(AppSize.width(value: 8)),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.instance.white500, // Border color
            width: .5, // Border width
          ),
          color: AppColors.instance.white50,
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage(
              // url: item.image,
              path: AssetsImagesPath.instance.product1,
              height: AppSize.height(value: 47),
              width: AppSize.width(value: 51),
            ),
            const Gap(height: 10),
            AppText(
              // data: item.name ?? "",
              data: "Trkil Products",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black200,
            ),
          ],
        ),
      ),
    );
  }
}
