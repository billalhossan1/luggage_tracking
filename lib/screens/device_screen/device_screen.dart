import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/device_screen/controller/device_screen_controller.dart';
import 'package:luggage_tracking/screens/share_item_screen/share_item_screen.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/widgets/item_tracker_widget.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image_circular.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/divider/app_divider.dart';
import 'package:luggage_tracking/widgets/service_widget/profile_top_widget.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class DeviceScreen extends StatelessWidget {
  DeviceScreen({super.key});
  final controller = Get.put(DeviceScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Device",
        showLeading: false,
        autoShowLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
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
                  ConnectBtn(
                    onTap: () {
                      Get.toNamed(AppRoutes.instance.addDeviceScanner);
                    },
                  ),
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
                          DeviceCustomTabButton(
                            controller: controller,
                            text: "My Item",
                            value: 1,
                            isSelected: controller.selectedItem.value == 1,
                          ),
                          const SizedBox(width: 10),
                          DeviceCustomTabButton(
                            controller: controller,
                            text: "Others Item",
                            value: 2,
                            isSelected: controller.selectedItem.value == 2,
                          ),
                        ],
                      ),
                    ),
                    AppDivider(),
                    Obx(() {
                      if (controller.selectedItem.value == 1) {
                        return Expanded(
                          child: Column(
                            children: [
                              // List of items
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return ItemTrackerWidget(
                                      showLocationRow: false,
                                      child: Icon(
                                        Icons.more_vert,
                                        size: AppSize.width(value: 14),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Bottom password section
                            ],
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Column(
                            children: [
                              // List of items
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return ItemTrackerWidget(
                                      showLocationRow: false,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                            ShowCustomBottomSheet(
                                              text1: "User Details",
                                              text1IconPath: Icon(Icons.person),
                                              text2: "Detach",
                                              text2IconPath: Icon(
                                                Icons.bookmark_remove,
                                              ),
                                              text1OnTap: () {
                                                Get.bottomSheet(
                                                  Wrap(
                                                    // 👈 This makes the bottom sheet wrap its content height
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              16,
                                                            ),
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              AppColors
                                                                  .instance
                                                                  .white50,
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                      12,
                                                                    ),
                                                                topRight:
                                                                    Radius.circular(
                                                                      12,
                                                                    ),
                                                              ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Gap(
                                                              height:
                                                                  AppSize.width(
                                                                    value: 16,
                                                                  ),
                                                            ),
                                                            ProfileTopWidget(
                                                              imgUrl:
                                                                  AssetsImagesPath
                                                                      .instance
                                                                      .person,
                                                              name:
                                                                  "Suporna Talukdar",
                                                              email:
                                                                  "Asadujjaman101@gmail,com",
                                                            ),
                                                            Gap(
                                                              height:
                                                                  AppSize.width(
                                                                    value: 16,
                                                                  ),
                                                            ),
                                                            Row(
                                                              spacing: 8,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(),
                                                                ),
                                                                Expanded(
                                                                  child: AppButton(
                                                                    height: 24,
                                                                    circularHeight:
                                                                        8,
                                                                    filColor:
                                                                        AppColors
                                                                            .instance
                                                                            .white500,
                                                                    title:
                                                                        "Track",
                                                                    titleColor:
                                                                        AppColors
                                                                            .instance
                                                                            .black500,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: AppButton(
                                                                    height: 24,
                                                                    circularHeight:
                                                                        8,
                                                                    filColor:
                                                                        AppColors
                                                                            .instance
                                                                            .black500,
                                                                    title:
                                                                        "Detach",
                                                                    titleColor:
                                                                        AppColors
                                                                            .instance
                                                                            .white500,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(),
                                                                ),
                                                              ],
                                                            ),

                                                            AppDivider(),
                                                            ItemTrackerWidget(),
                                                            Gap(
                                                              height:
                                                                  AppSize.width(
                                                                    value: 16,
                                                                  ),
                                                            ),
                                                            AppText(
                                                              data:
                                                                  "CONGRATULATION , Suporna accept your request",
                                                              fontSize:
                                                                  AppSize.width(
                                                                    value: 12,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  AppColors
                                                                      .instance
                                                                      .green1,
                                                            ),
                                                            Gap(
                                                              height:
                                                                  AppSize.width(
                                                                    value: 20,
                                                                  ),
                                                            ),
                                                            // AppButton(
                                                            //   onTap: () {
                                                            //     Get.offAllNamed(
                                                            //       AppRoutes
                                                            //           .instance
                                                            //           .navigationScreen,
                                                            //     );
                                                            //     Future.delayed(
                                                            //       Duration(
                                                            //         milliseconds:
                                                            //             100,
                                                            //       ),
                                                            //       () {
                                                            //         Get.toNamed(
                                                            //           AppRoutes
                                                            //               .instance
                                                            //               .trackItemScreen,
                                                            //         );
                                                            //       },
                                                            //     );
                                                            //   },
                                                            //   title:
                                                            //       "Go Track Item",
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            isScrollControlled: true,
                                          );
                                        },
                                        child: Icon(
                                          Icons.more_vert,
                                          size: AppSize.width(value: 14),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Bottom password section
                            ],
                          ),
                        );
                      }
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
  final Function()? moreAction;

  const TitleSubImgCard({
    super.key,
    this.imgPath,
    this.title,
    this.subTitle,
    this.moreAction,
  });

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
                      onTap:
                          moreAction ??
                          () {
                            Get.bottomSheet(
                              ShowCustomBottomSheet(),
                              isScrollControlled: true,
                            );
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

class ShowCustomBottomSheet extends StatelessWidget {
  final String? text1;
  final Widget? text1IconPath;
  final String? text2;
  final Widget? text2IconPath;
  final Function()? text1OnTap;
  const ShowCustomBottomSheet({
    super.key,
    this.text1,
    this.text1IconPath,
    this.text2,
    this.text2IconPath,
    this.text1OnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ListTile(
            onTap: text1OnTap,
            leading: text1IconPath ?? Icon(Icons.edit),
            title: AppText(data: text1 ?? "Edit"),
          ),
          ListTile(
            leading: text2IconPath ?? Icon(Icons.bookmark_remove),
            title: AppText(data: text2 ?? "deactive"),
          ),
        ],
      ),
    );
  }
}

class DeviceCustomTabButton extends StatelessWidget {
  final int? value;
  final String? text;
  final bool isSelected;
  final DeviceScreenController controller;

  const DeviceCustomTabButton({
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: AppText(
          data: text ?? "Tab",
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w500,
          color:
              isSelected
                  ? AppColors.instance.black500
                  : AppColors.instance.black200,
        ),
      ),
    );
  }
}
