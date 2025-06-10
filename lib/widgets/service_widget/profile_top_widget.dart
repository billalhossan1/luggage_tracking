import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image_circular.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class ProfileTopWidget extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String email;

  const ProfileTopWidget({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImageCircular(
          url: imgUrl,
          width: AppSize.width(value: 64),
          height: AppSize.width(value: 64),
          fit: BoxFit.cover,
          // color: AppColors.black300,
        ),
        Gap(width: AppSize.width(value: 12)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: name,
              fontSize: AppSize.width(value: 18),
              fontWeight: FontWeight.w500,
              color: AppColors.instance.black500,
            ),
            Gap(height: AppSize.width(value: 10)),
            AppText(
              data: email,
              fontSize: AppSize.width(value: 14),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.white600,
            ),
            Gap(height: AppSize.width(value: 6)),
          ],
        ),
      ],
    );
  }
}




