import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import '../../utils/app_size.dart';
import '../app_image/app_image.dart';

class HomeSlider extends StatefulWidget {
  final HomeScreenController controller;
  const HomeSlider({super.key, required this.controller});


  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            height: AppSize.height(value: 200),
            viewportFraction: 1,
            onPageChanged: (currentIndex, reason) {
              selectedIndex.value = currentIndex;
            },
          ),
          items: List.generate(widget.controller.bannerList.length, (index) {
            final slider = widget.controller.bannerList[index];
            return GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.instance.productDetailsScreen,arguments: {"productId":widget.controller.bannerList[index].product});
              },
              child: Container(
                width: screenWidth,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppImage(
                    url:slider.image??'',
                    fit: BoxFit.cover,
                    width: screenWidth,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    selectedIndex.dispose();
    super.dispose();
  }
}
