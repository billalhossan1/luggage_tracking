import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class SubPlanScreen extends StatelessWidget {
  const SubPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 30)),
              child: AppText(
                data: "Unlock your Subscription Plan",
                fontSize: AppSize.width(value: 24),
                fontWeight: FontWeight.w500,
                color: AppColors.instance.black400,
              ),
            ),

            PlanCard(
              onTap: () {
                Get.toNamed(AppRoutes.instance.locationScreen);
              },
              heading: "Annual plan",
              price: "\$114.99/year",
              offer1: "Permissions for Multiple Trackers",
              offer2: "sync with Garmin or Apple",
              offer3: "Personalized training plans",
            ),
            PlanCard(
              heading: "Monthly plan",
              price: "\$19.99/6month",
              offer1: "Permissions for Multiple Trackers",
              offer2: "sync with Garmin or Apple",
              offer3: "Personalized training plans",
            ),
            PlanCard(
              heading: "Free Trial",
              price: "Free",
              offer1: "Permissions for Multiple Trackers",
              offer2: "sync with Garmin or Apple",
              offer3: "Personalized training plans",
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String? heading;
  final String? offer1;
  final String? offer2;
  final String? offer3;
  final String? price;
  final bool isSelected;
  final Function()? onTap;
  const PlanCard({
    super.key,
    this.heading,
    this.offer1,
    this.offer2,
    this.offer3,
    this.price,
    this.isSelected = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 16),
          vertical: AppSize.width(value: 5),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 12),
          vertical: AppSize.width(value: 10),
        ),
        width: AppSize.width(value: double.infinity),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.instance.purple_50
                  : AppColors.instance.white100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? AppColors.instance.purple_500
                    : AppColors.instance.black400,
          ),
        ),
        child: Column(
          spacing: AppSize.width(value: 16),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: heading ?? "Annual plan",
              fontSize: AppSize.width(value: 18),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black400,
            ),
            AppText(
              data: price ?? "\$114.99/year",
              fontSize: AppSize.width(value: 14),
              fontWeight: FontWeight.w500,
              color: AppColors.instance.blue2,
            ),

            PlanCardRow(text: offer1 ?? "Permissions for Multiple Trackers"),
            PlanCardRow(text: offer2 ?? "sync with Garmin or Apple"),
            PlanCardRow(text: offer3 ?? "Personalized training plans"),
          ],
        ),
      ),
    );
  }
}

class PlanCardRow extends StatelessWidget {
  final String? text;
  const PlanCardRow({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(
          path: AssetsIconsPath.instance.planCardIcon,
          width: AppSize.width(value: 22),
          height: AppSize.width(value: 22),
        ),
        Gap(width: AppSize.width(value: 16)),
        AppText(
          data: text ?? "Permissions for Multiple Trackers",
          fontSize: AppSize.width(value: 14),
          fontWeight: FontWeight.w400,
          color: AppColors.instance.black200,
        ),
      ],
    );
  }
}
