import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/device_screen/controller/device_screen_controller.dart';
import 'package:luggage_tracking/screens/navigation_screen/controllers/navigation_screen_controller.dart';
import 'package:luggage_tracking/screens/share_item_screen/share_item_screen.dart';
import 'package:luggage_tracking/screens/tracker_item_screen/widgets/item_tracker_widget.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image_circular.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/device_custom_tab_button/device_custom_tab_button.dart';
import 'package:luggage_tracking/widgets/divider/app_divider.dart';
import 'package:luggage_tracking/widgets/service_widget/profile_top_widget.dart';
import 'package:luggage_tracking/widgets/snackbar_message/snack_bar_widget.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceScreenController>(
      init: DeviceScreenController(),
      builder: (controller) {
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
                              child: RefreshIndicator(
                                onRefresh: controller.onRefresh,
                                child: ListView.builder(
                                  itemCount: controller.devices.length,
                                  itemBuilder: (context, index) {
                                    return ItemTrackerWidget(
                                      showLocationRow: false,
                                      name: controller.devices[index].name,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                            ShowCustomBottomSheet(
                                              text1: "Edit",
                                              text1IconPath: const Icon(Icons.edit),
                                              text2: "Deactivate",
                                              text2IconPath: const Icon(Icons.delete),
                                              text1OnTap: () {
                                                Get.bottomSheet(
                                                  Wrap(
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.all(16),
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.instance.white50,
                                                          borderRadius: const BorderRadius.only(
                                                            topLeft: Radius.circular(12),
                                                            topRight: Radius.circular(12),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Gap(height: AppSize.width(value: 16)),
                                                            ProfileTopWidget(
                                                              imgUrl: controller.profile.profileModel.value?.profile??'',
                                                              name: controller.profile.profileModel.value?.name??'',
                                                              email: controller.profile.profileModel.value?.email??'',
                                                            ),
                                                            Gap(height: AppSize.width(value: 16)),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const Expanded(child: SizedBox()),
                                                                Expanded(
                                                                  child: AppButton(
                                                                    onTap: (){
                                                                      Get.find<NavigationScreenController>().changeIndex(2);
                                                                      Navigator.pop(context);
                                                                      Navigator.pop(context);
                                                                    },
                                                                    height: 24,
                                                                    circularHeight: 8,
                                                                    filColor: AppColors.instance.white500,
                                                                    title: "Track",
                                                                    titleColor: AppColors.instance.black500,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: AppButton(
                                                                    height: 24,
                                                                    circularHeight: 8,
                                                                    filColor: AppColors.instance.black500,
                                                                    title: "Detach",
                                                                    titleColor: AppColors.instance.white500,
                                                                  ),
                                                                ),
                                                                const Expanded(child: SizedBox()),
                                                              ],
                                                            ),
                                                            AppDivider(),
                                                             ItemTrackerWidget(name: controller.devices[index].name,showLocationRow:true,serial: controller.devices[index].serial,status: controller.devices[index].status ,),
                                                            Gap(height: AppSize.width(value: 16)),
                                                            AppText(
                                                              data: "CONGRATULATION , Suporna accept your request",
                                                              fontSize: AppSize.width(value: 12),
                                                              fontWeight: FontWeight.w400,
                                                              color: AppColors.instance.green1,
                                                            ),
                                                            Gap(height: AppSize.width(value: 20)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              text2OnTap: (){
                                                controller.deleteDevice(controller.devices[index].sId!);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            isScrollControlled: true,
                                          );
                                        },
                                        child: Icon(Icons.more_vert, size: AppSize.width(value: 14)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          } else {
                            if (!controller.isSubscribe) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showCustomSnackBar(title: "Failed", message: "You need to purchase premium subscription for access these item",isError: true);
                              });
                              return const SizedBox();
                            }

                            return Expanded(
                              child: ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return ItemTrackerWidget(
                                    showLocationRow: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                          ShowCustomBottomSheet(
                                            text1: "User Details",
                                            text1IconPath: const Icon(Icons.person),
                                            text2: "Detach",
                                            text2IconPath: const Icon(Icons.bookmark_remove),
                                            text1OnTap: () {
                                              Get.bottomSheet(
                                                Wrap(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(16),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.instance.white50,
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(12),
                                                          topRight: Radius.circular(12),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Gap(height: AppSize.width(value: 16)),
                                                          ProfileTopWidget(
                                                            imgUrl: AssetsImagesPath.instance.person,
                                                            name: "Suporna Talukdar",
                                                            email: "Asadujjaman101@gmail.com",
                                                          ),
                                                          Gap(height: AppSize.width(value: 16)),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              const Expanded(child: SizedBox()),
                                                              Expanded(
                                                                child: AppButton(
                                                                  height: 24,
                                                                  circularHeight: 8,
                                                                  filColor: AppColors.instance.white500,
                                                                  title: "Track",
                                                                  titleColor: AppColors.instance.black500,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: AppButton(
                                                                  height: 24,
                                                                  circularHeight: 8,
                                                                  filColor: AppColors.instance.black500,
                                                                  title: "Detach",
                                                                  titleColor: AppColors.instance.white500,
                                                                ),
                                                              ),
                                                              const Expanded(child: SizedBox()),
                                                            ],
                                                          ),
                                                          AppDivider(),
                                                           ItemTrackerWidget(),
                                                          Gap(height: AppSize.width(value: 16)),
                                                          AppText(
                                                            data: "CONGRATULATION , Suporna accept your request",
                                                            fontSize: AppSize.width(value: 12),
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColors.instance.green1,
                                                          ),
                                                          Gap(height: AppSize.width(value: 20)),
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
                                      child: Icon(Icons.more_vert, size: AppSize.width(value: 14)),
                                    ),
                                  );
                                },
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
      },
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
  final Function()? text2OnTap;
  const ShowCustomBottomSheet({
    super.key,
    this.text1,
    this.text1IconPath,
    this.text2,
    this.text2IconPath,
    this.text2OnTap,
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
            onTap: text2OnTap,
            leading: text2IconPath ?? Icon(Icons.bookmark_remove),
            title: AppText(data: text2 ?? "deactive"),
          ),
        ],
      ),
    );
  }
}
