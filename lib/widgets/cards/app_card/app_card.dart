import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double? padding;
  final double? borderRedius;
  final Function()? onTap;
  final Color? filColor;
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRedius,
    this.onTap,
    this.filColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSize.width(value: padding ?? 16)),
        width: AppSize.width(value: double.infinity),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.instance.black900.withValues(
                alpha: 0.07,
              ), // ছায়ার রঙ ও অপাসিটি
              offset: Offset(0, 2), // শুধুমাত্র নিচে ছায়া (x=0, y=4)
              blurRadius: 2, // ছায়ার ধোঁয়াশা
              spreadRadius: 0, // ছায়া কতটা ছড়াবে
            ),
          ],
          color: filColor ?? AppColors.instance.white50,
          borderRadius: BorderRadius.circular(borderRedius ?? 12),
        ),
        child: child,
      ),
    );
  }
}
