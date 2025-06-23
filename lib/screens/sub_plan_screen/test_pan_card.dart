

import 'package:flutter/cupertino.dart';

import '../../const/app_colors.dart';
import '../../const/assets_icons_path.dart';
import '../../utils/app_size.dart';
import '../../utils/gap.dart';
import '../../widgets/app_image/app_image.dart';
import '../../widgets/texts/app_text.dart';

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
            Gap(height: AppSize.height(value: 10),),
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
