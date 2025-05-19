import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double? padding;
  final double? borderRedius;
  const AppCard({super.key, required this.child, this.padding, this.borderRedius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.width(value:padding ?? 16)),
      width: AppSize.width(value: double.infinity),
      decoration: BoxDecoration(
        color: AppColors.instance.white50,
        borderRadius: BorderRadius.circular(borderRedius ?? 12),
      ),
      child: child,
    );
  }
}
