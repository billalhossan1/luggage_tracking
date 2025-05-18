
import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_const.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.data,
    this.fontSize = 16,
    this.textScaleFactor = 0.9,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.height,
    this.softWrap,
  });
  final String data;
  final double? fontSize;
  final double textScaleFactor;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? height;
  final bool? softWrap;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            height: height,
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            fontFamily: AppConst.fontFamily1,
          ),
      textScaler: TextScaler.linear(textScaleFactor),
    );
  }
}
