import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final double height;

  const HomeScreenAppBar({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.actions,
    this.height = 130, // default height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.instance.white50,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Leading widget or default back icon
            leading ?? const Icon(Icons.arrow_back),

            const SizedBox(width: 12),

            // Title and optional subtitle
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: title ?? "Home",
                    fontSize: AppSize.width(value: 14),
                    fontWeight: FontWeight.w500,
                    color: AppColors.instance.purple_500,
                  ),

                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    Gap(height: AppSize.width(value: 4)),
                    AppText(
                      data: subtitle!,
                      fontSize: AppSize.width(value: 13),
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.white700,
                    ),
                  ],
                ],
              ),
            ),

            // Actions or default icon
            if (actions != null && actions!.isNotEmpty)
              ...actions!
            else
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
