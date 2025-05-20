// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:luggage_tracking/const/app_colors.dart';
// import 'package:luggage_tracking/utils/app_size.dart';
// import 'package:luggage_tracking/utils/gap.dart';
// import 'package:luggage_tracking/widgets/texts/app_text.dart';

// class AppInputWidget extends StatefulWidget {
//   const AppInputWidget({
//     super.key,
//     required this.title,
//     this.hintText = "",
//     this.prefix,
//     this.suffixIcon,
//     this.isPassWord = false,
//     this.isSecondaryPassWord = false,
//     this.isEmail = false,
//     this.textInputAction = TextInputAction.next,
//     this.controller,
//     this.keyboardType,
//     this.fillColor,
//     this.elevation = 0.0,
//     this.elevationColor,
//     this.minLines = 1,
//     this.maxLines,
//     this.readOnly = false,
//     this.border,
//     this.errBorder,
//     this.titleColor,
//     this.onTap,
//     this.style,
//     this.secondController,
//     this.inImpotant = true,
//   });

//   final String title;
//   final String hintText;
//   final Widget? prefix;
//   final Widget? suffixIcon;
//   final bool inImpotant;
//   final bool isPassWord;
//   final bool isSecondaryPassWord;
//   final bool readOnly;
//   final bool isEmail;
//   final TextInputAction? textInputAction;
//   final TextEditingController? controller;
//   final TextEditingController? secondController;
//   final TextInputType? keyboardType;
//   final Color? fillColor;
//   final Color? titleColor;
//   final double elevation;
//   final Color? elevationColor;
//   final int minLines;
//   final int? maxLines;
//   final InputBorder? border;
//   final InputBorder? errBorder;
//   final void Function()? onTap;
//   final TextStyle? style;

//   @override
//   State<AppInputWidget> createState() => _AppInputWidgetState();
// }

// class _AppInputWidgetState extends State<AppInputWidget> {
//   bool isShowPassWord = true;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Gap(height: 15),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             AppText(
//               data: widget.title,
//               fontWeight: FontWeight.w500,
//               color: widget.titleColor ?? AppColors.instance.black100,
//               fontSize: AppSize.width(value: 14),
//             ),
//             if (widget.inImpotant)
//             AppText(data: "*", color: AppColors.instance.red1),
//           ],
//         ),
//         const Gap(height: 10),
//         Material(
//           elevation: widget.elevation,
//           shadowColor: widget.elevationColor,
//           borderOnForeground: false,
//           borderRadius: BorderRadius.circular(
//             12,
//           ), // ✅ Updated border radius here
//           color: Colors.transparent,
//           child: TextFormField(
//             onTap: widget.onTap,
//             readOnly: widget.readOnly,
//             controller: widget.controller,
//             minLines: widget.minLines,
//             maxLines: widget.maxLines,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return "This field is required";
//               }
//               if (widget.isPassWord && value.length < 8) {
//                 return "Must be at last 8 characters.";
//               }
//               if (widget.isEmail) {
//                 if (value.toString().isEmail) return null;
//                 return "Please provide valid email address";
//               }
//               if (widget.secondController != null &&
//                   widget.isSecondaryPassWord) {
//                 if (value.toLowerCase() !=
//                     widget.secondController!.text.toLowerCase()) {
//                   return "Both passwords most match";
//                 }
//                 if (value.toLowerCase() ==
//                     widget.secondController!.text.toLowerCase()) {
//                   return null;
//                 }
//               }

//               return null;
//             },
//             keyboardType: widget.keyboardType,
//             textInputAction: widget.textInputAction,
//             obscureText: widget.isPassWord && isShowPassWord,
//             obscuringCharacter: "*",
//             textAlignVertical: TextAlignVertical.center,
//             style: widget.style,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: widget.fillColor ?? AppColors.instance.white50,
//               prefixIcon: widget.prefix,
//               suffixIcon:
//                   widget.isPassWord
//                       ? Container(
//                         margin: const EdgeInsets.all(5),
//                         width: AppSize.width(value: 10),
//                         height: AppSize.width(value: 10),
//                         child: IconButton(
//                           color: AppColors.instance.white100,
//                           padding: EdgeInsets.zero,
//                           highlightColor: AppColors.instance.white100,
//                           onPressed: () {
//                             setState(() {
//                               isShowPassWord = !isShowPassWord;
//                             });
//                           },
//                           icon:
//                               isShowPassWord
//                                   ? const Icon(Icons.visibility)
//                                   : const Icon(Icons.visibility_off),
//                         ),
//                       )
//                       : widget.suffixIcon,
//               hintText: widget.hintText,
//               hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
//                 color: AppColors.instance.black200,
//               ),
//               border:
//                   widget.border ??
//                   OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//               enabledBorder:
//                   widget.border ??
//                   OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//               focusedBorder:
//                   widget.border ??
//                   OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//               errorBorder:
//                   widget.errBorder ??
//                   OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.red),
//                   ),
//               focusedErrorBorder:
//                   widget.errBorder ??
//                   OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.red),
//                   ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class AppInputWidget extends StatefulWidget {
  const AppInputWidget({
    super.key,
    required this.title,
    this.hintText = "",
    this.prefix,
    this.suffixIcon,
    this.isPassWord = false,
    this.isSecondaryPassWord = false,
    this.isEmail = false,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.keyboardType,
    this.fillColor,
    this.elevation = 0.0,
    this.elevationColor,
    this.minLines = 1,
    this.maxLines,
    this.readOnly = false,
    this.border,
    this.errBorder,
    this.titleColor,
    this.onTap,
    this.style,
    this.secondController,
    this.inImpotant = true,
  }) : assert(!isPassWord || controller != null,
          'Controller is required when isPassWord is true');

  final String title;
  final String hintText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool inImpotant;
  final bool isPassWord;
  final bool isSecondaryPassWord;
  final bool readOnly;
  final bool isEmail;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextEditingController? secondController;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final Color? titleColor;
  final double elevation;
  final Color? elevationColor;
  final int minLines;
  final int? maxLines;
  final InputBorder? border;
  final InputBorder? errBorder;
  final void Function()? onTap;
  final TextStyle? style;

  @override
  State<AppInputWidget> createState() => _AppInputWidgetState();
}

class _AppInputWidgetState extends State<AppInputWidget> {
  bool isShowPassWord = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(height: 15),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppText(
              data: widget.title,
              fontWeight: FontWeight.w500,
              color: widget.titleColor ?? AppColors.instance.black100,
              fontSize: AppSize.width(value: 14),
            ),
            if (widget.inImpotant)
              AppText(data: "*", color: AppColors.instance.red1),
          ],
        ),
        const Gap(height: 10),
        Material(
          elevation: widget.elevation,
          shadowColor: widget.elevationColor,
          borderOnForeground: false,
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
          child: TextFormField(
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            controller: widget.controller,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              if (widget.isPassWord && value.length < 8) {
                return "Must be at least 8 characters.";
              }
              if (widget.isEmail) {
                if (!value.isEmail) return "Please provide valid email address";
              }
              if (widget.secondController != null &&
                  widget.isSecondaryPassWord) {
                if (value.toLowerCase() !=
                    widget.secondController!.text.toLowerCase()) {
                  return "Both passwords must match";
                }
              }
              return null;
            },
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: widget.isPassWord && isShowPassWord,
            obscuringCharacter: "*",
            textAlignVertical: TextAlignVertical.center,
            style: widget.style,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.fillColor ?? AppColors.instance.white50,
              prefixIcon: widget.prefix,
              suffixIcon: widget.isPassWord
                  ? Container(
                      margin: const EdgeInsets.all(5),
                      width: AppSize.width(value: 10),
                      height: AppSize.width(value: 10),
                      child: IconButton(
                        color: AppColors.instance.white100,
                        padding: EdgeInsets.zero,
                        highlightColor: AppColors.instance.white100,
                        onPressed: () {
                          setState(() {
                            isShowPassWord = !isShowPassWord;
                          });
                        },
                        icon: isShowPassWord
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    )
                  : widget.suffixIcon,
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.instance.black200,
                  ),
              border: widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
              enabledBorder: widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
              focusedBorder: widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
              errorBorder: widget.errBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
              focusedErrorBorder: widget.errBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
