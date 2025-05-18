import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Category'),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 10,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Container(
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
                Expanded(
                  child: AppImage(path: AssetsImagesPath.instance.product2),
                ),
                SizedBox(height: 8),
                Text('Item $index'),
              ],
            ),
          );
        },
      ),
    );
  }
}
