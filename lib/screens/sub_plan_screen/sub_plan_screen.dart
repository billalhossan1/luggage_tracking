import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/screens/sub_plan_screen/controller/sub_plan_screen_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class SubPlanScreen extends StatelessWidget {
  const SubPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubPlanScreenController>(
      init: SubPlanScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Obx((){
            return SafeArea(
              child: controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.subscriptionPlanList.isEmpty
                  ? Center(
                child: AppText(
                  data: 'No subscription plans available',
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w500,
                  color: AppColors.instance.black400,
                ),
              )
                  : Column(
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
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.subscriptionPlanList.length,
                      itemBuilder: (context, index) {
                        final plan = controller.subscriptionPlanList[index];
                        return PlanCard(
                          onTap: () => controller.onTapSubscription(
                            context,
                            paymentUrl: plan.paymentLink ?? "",
                          ),
                          heading: plan.title,
                          price: "${plan.price}",
                          offer1: plan.description,
                          isSelected: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
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
          color: isSelected
              ? AppColors.instance.purple_50
              : AppColors.instance.white100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.instance.purple_500
                : AppColors.instance.black400,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: heading ?? "Plan",
              fontSize: AppSize.width(value: 18),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black400,
            ),
            AppText(
              data: price ?? "",
              fontSize: AppSize.width(value: 14),
              fontWeight: FontWeight.w500,
              color: AppColors.instance.blue2,
            ),
            SizedBox(height: AppSize.width(value: 10)),
            if (offer1 != null) PlanCardRow(text: offer1),
            if (offer2 != null) PlanCardRow(text: offer2),
            if (offer3 != null) PlanCardRow(text: offer3),
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
        Expanded(
          child: AppText(
            data: text ?? "",
            fontSize: AppSize.width(value: 14),
            fontWeight: FontWeight.w400,
            color: AppColors.instance.black200,
          ),
        ),
      ],
    );
  }
}
