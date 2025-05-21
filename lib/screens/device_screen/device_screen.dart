import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/screens/share_item_screen/share_item_screen.dart';
import 'package:luggage_tracking/screens/share_item_user_screen/controller/share_item_user_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image_circular.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/divider/app_divider.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShareItemUserController());

    return Scaffold(
      appBar: CustomAppBar(title: "Device"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppCard(
              borderRedius: 20,
              padding: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    data: "Add Trkil Device",
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.black400,
                  ),
                  // Replace with your actual button
                  ConnectBtn(),
                ],
              ),
            ),
            Gap(height: AppSize.width(value: 20)),
            Expanded(
              child: AppCard(
                padding: 16,
                child: Column(
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          CustomTabButton(
                            controller: controller,
                            text: "Shared Products",
                            value: 1,
                            isSelected: controller.selectedItem.value == 1,
                          ),
                          const SizedBox(width: 10),
                          CustomTabButton(
                            controller: controller,
                            text: "Share History",
                            value: 2,
                            isSelected: controller.selectedItem.value == 2,
                          ),
                        ],
                      ),
                    ),
                    AppDivider(),
                    Gap(height: 10),
                    Obx(() {
                      return Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return TitleSubImgCard(
                                    title: "Big Samsonite Luggage",
                                    imgPath: AssetsIconsPath.instance.product3,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleSubImgCard extends StatelessWidget {
  final String? imgPath;
  final String? title;
  final String? subTitle;

  const TitleSubImgCard({super.key, this.imgPath, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          AppImageCircular(
            path: imgPath ?? AssetsImagesPath.instance.person,
            width: AppSize.width(value: 44),
            height: AppSize.width(value: 44),
          ),
          Gap(width: AppSize.width(value: 14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: title ?? "Big Samsonite Luggage",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.black300,
                    ),
                    GestureDetector(
                      onTap: () {
                        showCustomBottomSheet();
                      },
                      child: Icon(
                        Icons.more_vert,
                        size: AppSize.width(value: 14),
                      ),
                    ),
                  ],
                ),
                Gap(height: AppSize.width(value: 12)),
                AppText(
                  data: subTitle ?? "D.ID- 1322364654465",
                  fontSize: AppSize.width(value: 12),
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.black200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomBottomSheet() {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.instance.white200,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 50,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),
          ListTile(leading: const Icon(Icons.edit), title: const Text("Edit")),
          ListTile(
            leading: const Icon(Icons.bookmark_remove),
            title: const Text("deactive"),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

class CustomTabButton extends StatelessWidget {
  final int? value;
  final String? text;
  final bool isSelected;
  final ShareItemUserController controller;

  const CustomTabButton({
    super.key,
    required this.controller,
    required this.isSelected,
    this.value,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectItem(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 8),
          vertical: AppSize.width(value: 10),
        ),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.instance.purple_200
                  : AppColors.instance.white500,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AppText(
          data: text ?? "Tab",
          fontSize: AppSize.width(value: 12),
          fontWeight: FontWeight.w500,
          color:
              isSelected
                  ? AppColors.instance.white300
                  : AppColors.instance.black200,
        ),
      ),
    );
  }
}
