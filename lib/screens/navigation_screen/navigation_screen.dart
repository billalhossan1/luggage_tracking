import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/screens/account_screen/account_screen.dart';
import 'package:luggage_tracking/screens/device_screen/device_screen.dart';
import 'package:luggage_tracking/screens/home_screen/home_screen.dart';
import 'package:luggage_tracking/screens/navigation_screen/controllers/navigation_screen_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';

import '../tracker_item_screen/tracker_item_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NavigationScreenController(),
      builder: (controller) {
        return Scaffold(
          body: controller.isLoading
              ? SizedBox()
              : IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              const HomeScreen(),
              DeviceScreen(),
              // controller.selectedIndex.value == 2 && !controller.isSubscribe
              //     ? SubscriptionRequiredScreen()
              //     :
              const TrackerItemScreen(),
              AccountScreen(),
            ],
          ),
          bottomNavigationBar: controller.isLoading
              ? SizedBox()
              : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: AppSize.width(value: 20),
                  top: AppSize.width(value: 4),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.instance.white50,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (index) {
                      final isSelected = controller.selectedIndex.value == index;

                      final iconPaths = [
                        "assets/icons/home_nav.png",
                        AssetsIconsPath.instance.deviceNav,
                        AssetsIconsPath.instance.trackerNav,
                        AssetsIconsPath.instance.accountNav,
                      ];

                      return InkWell(
                        onTap: () => controller.changeIndex(index),
                        overlayColor: WidgetStatePropertyAll(AppColors.instance.transparent),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: isSelected
                              ? BoxDecoration(
                            color: AppColors.instance.purple_500, // Purple circle
                            shape: BoxShape.circle,
                          )
                              : null,
                          child: AppImage(
                            path: iconPaths[index],
                            width: 24,
                            height: 24,
                            iconColor: isSelected ? Colors.white : AppColors.instance.black200,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              // Pill indicator
              Positioned(
                bottom: 6,
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}