import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
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
    this.gradient,
    this.titleSize
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
  final Gradient? gradient;
  final double? titleSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? Get.width,
        height: height ?? AppSize.width(value: 50.0),
        alignment: Alignment.center,
        margin: margin,
        decoration:
            decoration ??
            ShapeDecoration(
              gradient:
                  gradient ??
                  LinearGradient(
                    begin: Alignment(0.00, 0.50),
                    end: Alignment(1.00, 0.50),
                    colors: [
                      const Color(0xFFFFD858),
                      const Color(0xFFFFB953),
                      const Color(0xFFFF954E),
                    ],
                  ),
              shape: RoundedRectangleBorder(
                borderRadius:borderRadius ?? BorderRadius.circular(40),
              ),
            ),
        // BoxDecoration(
        //   gradient:
        //       gradient ??
        //       LinearGradient(
        //         colors: [
        //           AppColors.yellow,
        //           AppColors.yellow.withOpacity(0.8),
        //         ],
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //       ),
        //   borderRadius:
        //       borderRadius ??
        //       BorderRadius.circular(AppSize.width(value: 10)),
        // ),
        child:
            isLoading
                ? SizedBox(
                  height: circularHeight ?? AppSize.width(value: 30.0),
                  width: circularHeight ?? AppSize.width(value: 30.0),
                  child: const CircularProgressIndicator(
                    // color: AppColors.white50,
                    strokeWidth: 2,
                  ),
                )
                : AppText(
                  data: title,
                  // color: titleColor ?? AppColors.black500,
                  fontWeight: FontWeight.w700,
                  fontSize:titleSize ?? 16,
                ),
      ),
    );
  }
}
