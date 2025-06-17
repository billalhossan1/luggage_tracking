import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class AddDescripsion extends StatelessWidget {
  const AddDescripsion({
    super.key,
    this.controller,
    this.hintText = '',
    this.fillColor,
    this.border,
    this.errBorder,
    required this.title,
    this.hintStyle, this.boxSize,
    this.validatior = true,
    
  });

  final String title;
  final TextEditingController? controller;
  final String hintText;
  final Color? fillColor;
  final InputBorder? border;
  final InputBorder? errBorder;
  final TextStyle? hintStyle;
  final double? boxSize;
  final bool validatior;

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none, // No border color
    );

    final errorOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none, // No border color
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(height: 15),
        AppText(
          data: title,
          fontWeight: FontWeight.w500,
          color: AppColors.instance.black100,
          fontSize: AppSize.width(value: 14),
        ),
        const Gap(height: 10),
        SizedBox(
          height: AppSize.width(value: boxSize ?? 162),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,

            expands: true,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(color: AppColors.instance.black700),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(

              hintText: hintText,
              hintStyle:
                  hintStyle ?? TextStyle(color: AppColors.instance.white200),
              filled: true,
              fillColor: fillColor ?? AppColors.instance.white50,
              border: border ?? outlineBorder,
              enabledBorder: border ?? outlineBorder,
              focusedBorder: border ?? outlineBorder,
              errorBorder: errBorder ?? errorOutlineBorder,
              focusedErrorBorder: errBorder ?? errorOutlineBorder,
            ),
            validator: validatior?(value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            }:null,
          ),
        ),
      ],
    );
  }
}
