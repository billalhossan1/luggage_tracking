import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/utils/app_all_log/app_log.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/home_screen_appbar.dart';
import 'package:luggage_tracking/widgets/service_widget/service_category_box.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with some basic properties
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: AppSize.width(value: 56),
            pinned: true, // height when expanded
            flexibleSpace: HomeScreenAppBar(
              actions: [
                AppImage(
                  path: AssetsIconsPath.instance.search,
                  width: AppSize.width(value: 24),
                  height: AppSize.width(value: 24),
                ),
                Gap(width: AppSize.width(value: 16)),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.instance.notificationScreen);
                  },
                  child: AppImage(
                    path: AssetsIconsPath.instance.notification,
                    width: AppSize.width(value: 24),
                    height: AppSize.width(value: 24),
                  ),
                ),
              ],
              title: "Welcome to Trkil",
              subtitle: "Every move matters",
              leading: AppImage(
                path: AssetsImagesPath.instance.homeLogo,
                width: AppSize.width(value: 40),
                height: AppSize.width(value: 40),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: HomeBannerSection(
              onTap: () {
                appLog(
                  "Home Page OnTap Clicked ====>>>>> Banner Section Home Page👍👍",
                );
              },
            ),
          ),

          itemTitleOption(
            name: "Categories",
            onTapCall: () {
              Get.toNamed(AppRoutes.instance.categoryScreen);
            },
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 16, bottom: 16),
              child: SizedBox(
                width: AppSize.width(value: 92),
                height: AppSize.height(
                  value: 92,
                ), // ekta fixed height dite hobe
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // horizontal scroll
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.width(value: 12),
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    // var item = controller.services[index];
                    return ServiceCategoryBox();
                  },
                ),
              ),
            ),
          ),
          itemTitleOption(
            name: "Vest Products",
            onTapCall: () {
              Get.toNamed(AppRoutes.instance.productCategoryScreen);
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 16, bottom: 16),
              child: SizedBox(
                height: AppSize.height(
                  value: 240,
                ), // ekta fixed height dite hobe
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // horizontal scroll
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.width(value: 12),
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    // var item = controller.services[index];
                    return Padding(
                      padding: EdgeInsets.only(right: AppSize.width(value: 8)),
                      child: ProductCard(
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.productDetailsScreen);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Function()? onTap;
  const ProductCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        width: AppSize.width(value: 163),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.instance.white500, // Border color
            width: .5, // Border width
          ),
          color: AppColors.instance.white50,
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: AppSize.width(value: 18),
                      height: AppSize.width(value: 18),
                      decoration: BoxDecoration(
                        color: AppColors.instance.white200,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppImage(
                      path: AssetsIconsPath.instance.favorate,
                      width: AppSize.width(value: 18),
                      height: AppSize.width(value: 18),
                    ),
                  ],
                ),
                AppImage(
                  path: AssetsImagesPath.instance.product2,
                  fit: BoxFit.cover,
                  width: AppSize.width(value: 115),
                  height: AppSize.width(value: 115),
                ),
              ],
            ),
            Gap(height: AppSize.width(value: 16)),
            AppText(
              data: "Luggage Tag",
              fontSize: AppSize.width(value: 14),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black400,
            ),
            Gap(height: AppSize.width(value: 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: "Trkil",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.black200,
                    ),
                    Gap(height: AppSize.width(value: 8)),
                    AppText(
                      data: "\$${3.00}",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w600,
                      color: AppColors.instance.black400,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.instance.white500,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.add,
                    size: AppSize.width(value: 18),
                    color: AppColors.instance.purple_500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBannerSection extends StatelessWidget {
  final Function()? onTap;
  const HomeBannerSection({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(AppSize.width(value: 16)),
        width: AppSize.width(value: double.infinity),
        height: AppSize.width(value: 173),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AssetsImagesPath.instance.bannerBg,
            ), // অথবা NetworkImage(...)
            fit: BoxFit.cover, // optional: image কিভাবে fit করবে
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSize.width(value: 16),
            bottom: AppSize.width(value: 16),
            right: AppSize.width(value: 16),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: AppImage(path: AssetsImagesPath.instance.bannerProduct),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      data: "Track with Ease",
                      fontSize: AppSize.width(value: 18),
                      fontWeight: FontWeight.w600,
                      color: AppColors.instance.white50,
                    ),
                    Gap(height: AppSize.width(value: 12)),
                    AppText(
                      data: "Never Lose What Matters",
                      fontSize: AppSize.width(value: 13),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.white400,
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.instance.white400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AppText(
                        data: "Buy Now",
                        fontSize: AppSize.width(value: 14),
                        fontWeight: FontWeight.w500,
                        color: AppColors.instance.black400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

SliverToBoxAdapter itemTitleOption({
  required void Function()? onTapCall,
  required String name,
}) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(data: name, fontWeight: FontWeight.w500, fontSize: 20),
          GestureDetector(
            onTap: onTapCall,
            child: AppText(
              data: "View All",
              fontWeight: FontWeight.w400,
              color: AppColors.instance.blue1,
            ),
          ),
        ],
      ),
    ),
  );
}
