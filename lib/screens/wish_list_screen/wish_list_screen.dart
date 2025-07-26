import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/cards/product_card.dart';
import 'controller/wish_list_controller.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<WishListController>(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: "Wish List"),
          body: Obx(
                () => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : controller.wishListItems.isEmpty
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

                return Column(
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
                        itemCount: controller.wishListItems.length,
                        padding: EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            productItem: controller.wishListItems[index].product, isBookmarked: true,
                            onBookmarkToggle: () {
                              // Logger().e("Bookmark Toggled: ${controller.productList[index].sId}");
                              controller.onBookMarkTogle(controller.wishListItems[index].product!);

                              // controller.onBookMarkTogle(controller.productList[index].bookmark??false);
                              // controller.getProductList();

                            },
                          );
                        },
                      ),
                    ),
                    // Show pagination progress bar at the bottom
                    if (controller.isPaginationLoading.value)
                      LinearProgressIndicator(),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 50, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "No items in your wishlist",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            "Start adding items to your wishlist!",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
