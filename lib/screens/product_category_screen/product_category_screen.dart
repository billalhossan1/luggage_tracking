import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/cards/product_card.dart';

class ProductCategoryScreen extends StatelessWidget {
  const ProductCategoryScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Product Category'),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: 10,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {

          // return ProductCard(isBookmarked: , onBookmarkToggle: () {  },
          // );
        },
      ),
    );
  }
}
