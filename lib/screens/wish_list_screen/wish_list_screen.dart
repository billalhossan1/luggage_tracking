import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
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
        return Scaffold(appBar: CustomAppBar(title: "Wish List"),body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.80,
            ),
            itemCount: 10,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return ProductCard(isBookmarked:false, onBookmarkToggle: () {  },
              );
            },
          ),);
      }
    );
  }
}
