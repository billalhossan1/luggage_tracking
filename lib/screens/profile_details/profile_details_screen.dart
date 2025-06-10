import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/profile_details/controller/profile_details_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/btn_icon_text.dart';
import 'package:luggage_tracking/widgets/divider/app_divider.dart';
import 'package:luggage_tracking/widgets/service_widget/profile_top_widget.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileDetailsController>(
      init: ProfileDetailsController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: "Profile Details"),
          body: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 20)),
            child: SingleChildScrollView(
              child: Obx(()=>Column(
                spacing: AppSize.width(value: 16),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileTopWidget(
                    imgUrl: controller.profileModel.value?.profile ?? '',
                    name: controller.profileModel.value?.name??'no Name',
                    email: controller.profileModel.value?.email??'email not exist',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BtnIconText(
                        onTap: (){
                          Get.toNamed(AppRoutes.instance.profileEditScreen);
                        },
                        text: "Edit",
                        iconPath: AssetsIconsPath.instance.edit,
                      ),
                      Gap(width: AppSize.width(value: 16)),

                      GestureDetector(
                        onTap: () {
                          //   Get.toNamed(AppRoutes.instance.profileEditScreen);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.instance.purple_500,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(value: 10),
                            vertical: AppSize.width(value: 8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.instance.white50,
                                size: AppSize.width(value: 14),
                              ),
                              Gap(width: AppSize.width(value: 8)),
                              AppText(
                                data: "Add Item",
                                color: AppColors.instance.white50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppDivider(),
                  ProfileTitleSubtitle(
                    title: "Registration no",
                    subTitle: "#${controller.profileModel.value?.sId}" ?? '',
                  ),
                  ProfileTitleSubtitle(title: "Name", subTitle: controller.profileModel.value?.name ?? 'no name'),
                  ProfileTitleSubtitle(title: "Contact No", subTitle: controller.profileModel.value?.contact ??'no number added'),
                  ProfileTitleSubtitle(
                    title: "Email",
                    subTitle:controller.profileModel.value?.email??"email doesn't exist",
                  ),
                  ProfileTitleSubtitle(
                    title: "Date of birth",
                    subTitle: controller.profileModel.value?.dateOfBirth??'not added',
                  ),
                  ProfileTitleSubtitle(title: "Gender", subTitle: controller.profileModel.value?.gender??'not added'),
                  ProfileTitleSubtitle(title: "Occupation", subTitle: controller.profileModel.value?.occupation??'not added'),
                  ProfileTitleSubtitle(
                    title: "Address",
                    subTitle: controller.profileModel.value?.address??'not added',
                  ),
                ],
              ),)
            ),
          ),
        );
      }
    );
  }
}


class ProfileTitleSubtitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const ProfileTitleSubtitle({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          data: title,
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w400,
          color: AppColors.instance.black100,
        ),
        Gap(height: AppSize.width(value: 8)),
        AppText(
          data: subTitle,
          fontSize: AppSize.width(value: 14),
          fontWeight: FontWeight.w400,
          color: AppColors.instance.black300,
        ),
      ],
    );
  }
}
