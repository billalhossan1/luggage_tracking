import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';

class CheckBoxWithText extends StatelessWidget {
  const CheckBoxWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: AppColors.instance.green1),
          child: Checkbox(
            activeColor: AppColors.instance.white200,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            side: WidgetStateBorderSide.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return BorderSide(color: AppColors.instance.white600);
              } else {
                return BorderSide(color: AppColors.instance.white600);
              }
            }),
            value: true, // static value
            checkColor: AppColors.instance.purple_500,
            fillColor: WidgetStatePropertyAll(AppColors.instance.white200),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.width(value: 5.0)),
            ),
            onChanged: null, // disables the checkbox
          ),
        ),
        Gap(width: AppSize.width(value: 8)),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: AppSize.width(value: AppSize.width(value: 16)),
              fontFamily: AppConst.fontFamily1,
              height: 1.5,
              color: AppColors.instance.white600,
            ),
            children: [
              TextSpan(
                text: 'I agree with ',
                style: TextStyle(
                  fontSize: AppSize.width(value: 12),
                  fontWeight: FontWeight.w400,
                  fontFamily: AppConst.fontFamily1,
                  color: AppColors.instance.black200,
                ),
              ),
              TextSpan(
                text: 'Terms & Service',
                style: TextStyle(
                  fontSize: AppSize.width(value: 12),
                  fontWeight: FontWeight.w400,
                  fontFamily: AppConst.fontFamily1,
                  color: AppColors.instance.blue1,
                ),
              ),
              TextSpan(
                text: ' and ',
                style: TextStyle(
                  fontSize: AppSize.width(value: 12),
                  fontWeight: FontWeight.w400,
                  fontFamily: AppConst.fontFamily1,
                  color: AppColors.instance.black200,
                ),
              ),
              TextSpan(
                text: 'Privacy Policy.',
                style: TextStyle(
                  fontSize: AppSize.width(value: 12),
                  fontWeight: FontWeight.w400,
                  fontFamily: AppConst.fontFamily1,
                  color: AppColors.instance.blue1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
