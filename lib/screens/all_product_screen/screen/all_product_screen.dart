import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/all_product_screen/controller/all_product_controller.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/cards/product_card.dart';

import '../../../utils/app_size.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllProductPaginationController>(
      init: AllProductPaginationController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: 'All Products'),
          body: Obx(
                () => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : controller.productListItems.isEmpty
                ? _buildEmptyState() // Show empty state if no items in the list
                : LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                int crossAxisCount = 2; // Default for small screens

                if (width > 600 && width <= 900) {
                  crossAxisCount = 3; // Medium screen
                } else if (width > 900) {
                  crossAxisCount = 4; // Large screen
                }

                return RefreshIndicator(
                  onRefresh: () {return controller.onRefresh(); },
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          controller: controller.scrollController,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio:
                            AppSize.size.width * 0.40 / (AppSize.size.width * 0.40 * 1.4), // Adjust aspect ratio
                          ),
                          itemCount: controller.productListItems.length,
                          padding: EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            var product = controller.productListItems[index];
                            return ProductCard(isBookmarked:product.bookmark??false , onBookmarkToggle: (){
                              controller.onBookMarkTogle(product);
                            },productItem: product,);
                          },
                        ),
                      ),
                      if (controller.isPaginationLoading.value)
                        LinearProgressIndicator(),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child:  Text(
        "No Product Available",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
