import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/category_screnn/controller/all_category_controller.dart';
import 'package:luggage_tracking/screens/device_screen/model/device_model.dart';
import 'package:luggage_tracking/screens/home_screen/model/category_list_model.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllCategoryController>(
      init: AllCategoryController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Category'),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: controller.categoryList.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return CategoryCard(
                onTap: () {
                  Get.toNamed(AppRoutes.instance.productCategoryScreen);
                }, categoryItem: controller.categoryList[index],
              );
            },
          ),
        );
      }
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Function()? onTap;
  final CategoryItem categoryItem;
  const CategoryCard({super.key, this.onTap, required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    final base = categoryItem.image??'';
    final image  = Urls.imageBaseUrl+base;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.instance.white50,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.instance.black50, // 7% black
              offset: Offset(0, 0),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: AppImage(url: image)),
            SizedBox(height: 8),
            AppText(data:categoryItem.name??''),
          ],
        ),
      ),
    );
  }
}
