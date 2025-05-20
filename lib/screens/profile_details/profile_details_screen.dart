import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';
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
    return Scaffold(
      appBar: CustomAppBar(title: "Profile Details"),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 20)),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSize.width(value: 16),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileTopWidget(
                imgPath: AssetsImagesPath.instance.person,
                name: "Mr. Spatch",
                email: "Spatch@gmail,com",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BtnIconText(
                    text: "Edit",
                    iconPath: AssetsIconsPath.instance.about,
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
                subTitle: "#131213542253",
              ),
              ProfileTitleSubtitle(title: "Name", subTitle: "Mr. Spatch"),
              ProfileTitleSubtitle(title: "Contact No", subTitle: "+099999"),
              ProfileTitleSubtitle(
                title: "Email",
                subTitle: "mahmud@gmail.com",
              ),
              ProfileTitleSubtitle(
                title: "Date of birth",
                subTitle: "17 dec, 2024",
              ),
              ProfileTitleSubtitle(title: "Gender", subTitle: "Male"),
              ProfileTitleSubtitle(title: "Occupation", subTitle: "Operator"),
              ProfileTitleSubtitle(
                title: "Address",
                subTitle: "76/4 R no. 60/1 Rue des Saints-Paris, 75005 Paris",
              ),
            ],
          ),
        ),
      ),
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
