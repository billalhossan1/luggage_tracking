import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';

class AppDivider extends StatelessWidget {
  final double? vertical;
  const AppDivider({super.key, this.vertical});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSize.width(value: vertical ?? 10),
      ),
      child: Divider(color: AppColors.instance.white600, height: 1),
    );
  }
}
