import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image_circular.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/texts/add_descrepsion.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';
import 'package:luggage_tracking/widgets/texts/icon_text_row.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (controller) {
          return Scaffold(
              appBar: CustomAppBar(title: "Account", showLeading: false),
              body: Obx(()=>Padding(
                padding: EdgeInsets.all(AppSize.width(value: 16)),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: AppSize.width(value: 12),
                    children: [
                      Column(
                        spacing: AppSize.width(value: 8),
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoutes.instance.profileDetailsScreen,arguments: {
                                "profile-model":controller.profileModel
                              });
                            },
                            child: AppImageCircular(
                              url: controller.profileModel.value?.profile,
                              width: AppSize.width(value: 72),
                              height: AppSize.width(value: 72),
                              fit: BoxFit.cover,
                            ),
                          ),
                          AppText(
                            data: controller.profileModel.value?.name ?? "no name",
                            fontSize: AppSize.width(value: 18),
                            fontWeight: FontWeight.w500,
                            color: AppColors.instance.black500,
                          ),
                          AppText(
                            data: controller.profileModel.value?.email ?? "no email",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.purple_500,
                          ),
                        ],
                      ),
                      IcontextRow(
                        icon: Icon(FontAwesomeIcons.crown,color: Colors.black38,),
                        text: "My Plan",
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.myPlanScreen);
                        },
                      ),

                      IcontextRow(
                        iconPath: AssetsIconsPath.instance.wishList,
                        text: "Wish list",
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.wishListScreen);
                        },
                      ),
                      IcontextRow(
                        iconPath: AssetsIconsPath.instance.dealCart,
                        text: "Dealing History ",
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.dealingHistoryScreen);
                        },
                      ),

                      IcontextRow(
                        iconPath: AssetsIconsPath.instance.setting,
                        text: "Account Setting",
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.accountSettingScreen);
                        },
                      ),
                      IcontextRow(
                        iconPath: AssetsIconsPath.instance.about,
                        text: "About",
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.acoutScreen);
                        },
                      ),
                      IcontextRow(
                        iconPath: AssetsIconsPath.instance.workFunc,
                        text: "Work Functionality",
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.workFuncScreen);
                        },
                      ),
                      IcontextRow(
                        iconPath: AssetsIconsPath.instance.terms,
                        text: "Terms & Conditions",
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.termsAndCondionScreen);
                        },
                      ),
                      IcontextRow(
                        iconPath: AssetsIconsPath.instance.faq,
                        text: "FAQ",
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.faqScreen);
                        },
                      ),
                      IcontextRow(
                        iconPath: AssetsIconsPath.instance.feedback,
                        text: "Feedback",
                        onTap: () {
                          Get.bottomSheet(
                            FeedBackRattinigBottomSheet(controller: controller),
                          );
                        },
                      ),
                      IcontextRow(
                        onTap: (){
                          Get.bottomSheet(
                            LogoutBottomSheet(),
                          );
                        },
                        iconPath: AssetsIconsPath.instance.logout,
                        text: "Log Out",
                      ),
                    ],
                  ),
                ),
              ),)
          );
        }
    );
  }
}
class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Dynamic height
          crossAxisAlignment:
          CrossAxisAlignment.start, // Left align all children
          children: [
            AppText(
              data: "Are you sure ?",
              fontSize: AppSize.width(value: 20),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black500,
            ),
            Gap(height: AppSize.width(value: 20)),
            AppText(
              data: "Do you want to log out from your account ?",
              fontSize: AppSize.width(value: 16),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black300,
            ),
            Gap(height: AppSize.width(value: 24)),
            Row(
              children: [
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 1,
                  child: AppButton(
                    height: 42,
                    title: "No",
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                Gap(width: AppSize.width(value: 8)),
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.instance.purple_500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Add logout logic here
                      Get.find<AccountController>().onTapLogout();
                    },
                    child: Text(
                      'Yes',

                      style: TextStyle(color: AppColors.instance.purple_500),
                    ),
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

class FeedBackRattinigBottomSheet extends StatelessWidget {
  const FeedBackRattinigBottomSheet({super.key, required this.controller});

  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.instance.white50,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(height: AppSize.width(value: 20)),

            AppText(
              data: "Your Feedback",
              fontSize: AppSize.width(value: 22),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black500,
            ),
            Gap(height: AppSize.width(value: 16)),
            Center(
              child: Obx(
                    () => RatingBar.builder(
                  initialRating: controller.rating.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder:
                      (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: controller.updateRatting,
                ),
              ),
            ),

            AddDescripsion(

              boxSize: 120,
              controller: controller.feedbackMessageTEController,
              fillColor: AppColors.instance.white50,
              title: "",
              hintText: "Review",
              hintStyle: TextStyle(
                fontFamily: AppConst.fontFamily1,
                fontSize: AppSize.width(value: 16),
                fontWeight: FontWeight.w400,
                color: AppColors.instance.black300,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.instance.black200,
                  width: 1.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 40)),
              child: AppButton(
                title: "Confirm",
                borderRadius: BorderRadius.circular(16),
                onTap: () {

                  double ratingValue = controller.rating.value;

                  String feedbackMessage = controller.feedbackMessageTEController.text;
                  controller.feedbackSubmit();
                  // For example, you could call a function like:
                  // controller.submitFeedback(ratingValue, feedbackMessage);
                  controller.feedbackMessageTEController.clear();
                  // Show a snack bar with the rating value
                  Get.back(); // Close bottom sheet

                  // You can also call a function to handle the feedback submission
                  // controller.submitFeedback(ratingValue, feedbackMessage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

