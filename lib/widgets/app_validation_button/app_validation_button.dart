import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class AppValidationButton extends StatelessWidget {
  const AppValidationButton({
    super.key,
    this.onTap,
    required this.title,
    this.isLoading = false,
    this.margin,
    this.circularHeight,
    this.height,
    this.width,
    this.borderRadius,
    this.decoration,
    this.titleColor,
    this.titleSize,

    required this.isRememberMe, // Add the reactive value here
  });

  final void Function()? onTap;
  final double? height;
  final double? circularHeight;
  final double? width;
  final String title;
  final bool isLoading;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final BoxDecoration? decoration;
  final Color? titleColor;
  final double? titleSize;
  final bool isRememberMe; // Reactive value for the button color

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? Get.width,
        height: height ?? AppSize.width(value: 50.0),
        alignment: Alignment.center,
        margin: margin,
        decoration: decoration ??
            BoxDecoration(
              color: isRememberMe ? AppColors.instance.purple_500 : Colors.black12, // Use the reactive value here
              borderRadius: borderRadius ?? BorderRadius.circular(8),
            ),
        child: isLoading
            ? SizedBox(
          height: circularHeight ?? AppSize.width(value: 30.0),
          width: circularHeight ?? AppSize.width(value: 30.0),
          child: const CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
            : AppText(
          data: title,
          color:isRememberMe ? AppColors.instance.white300:AppColors.instance.black300,
          fontWeight: FontWeight.w400,
          fontSize: titleSize ?? 16,
        ),
      ),
    );
  }
}

