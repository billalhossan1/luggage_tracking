import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Notification",
        action: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: AppImage(path: AssetsIconsPath.instance.setting2),
          ),
        ],
      ),
      body: Column(
        children: const [
          NotificationCard(isRead: true),
          NotificationCard(isRead: false),
          NotificationCard(isRead: false),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final bool isRead;
  const NotificationCard({super.key, required this.isRead});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(value: 12),
        vertical: AppSize.width(value: 6),
      ),
      child: AppCard(
        padding: 16,
        filColor:
            isRead ? AppColors.instance.purple_50 : AppColors.instance.white200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  data: "Tracking Device Found",
                  fontSize: AppSize.width(value: 14),
                  fontWeight: FontWeight.w500,
                  color: AppColors.instance.black500,
                ),
                GestureDetector(
                  onTap: () {
                    // showCustomBottomSheet();
                  },
                  child: Icon(Icons.more_vert, size: AppSize.width(value: 14)),
                ),
              ],
            ),
            Gap(height: AppSize.width(value: 12)),
            AppText(
              data: "Your Tracking device ‘My Blue Bag’ is in your 12m of rend",
              fontSize: AppSize.width(value: 12),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black300,
              maxLines: 2,
            ),
            Gap(height: AppSize.width(value: 12)),
            AppText(
              data: "2:30 am",
              fontSize: AppSize.width(value: 12),
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black200,
            ),
          ],
        ),
      ),
    );
  }
}
