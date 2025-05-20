// import 'package:flutter/material.dart';
// import 'package:luggage_tracking/const/app_colors.dart';
// import 'package:luggage_tracking/const/app_const.dart';
// import 'package:luggage_tracking/utils/app_size.dart';

// class AppInputWidgetTwo extends StatefulWidget {
//   const AppInputWidgetTwo({
//     super.key,
//     this.hintText,
//     this.prefix,
//     this.suffixIcon,
//     this.isPassWord = false,
//     this.isEmail = false,
//     this.textInputAction = TextInputAction.next,
//     this.controller,
//     this.keyboardType,
//     this.fillColor,
//     this.elevation = 0.0,
//     this.elevationColor,
//     this.minLines = 1,
//     this.readOnly = false,
//     this.border,
//     this.errBorder,
//     this.borderRadius,
//     this.contentPadding,
//     this.style,
//     this.maxLines,
//     this.onFieldSubmitted,
//     this.onTap,
//     this.filled = true,
//     this.prefixIconConstraints,
//     this.textAlignVertical,
//     this.suffixIconConstraints,
//     this.onChanged,
//     this.isPassWordSecondValidation = false,
//     this.isOptional = false,
//     this.isPassWordSecondValidationController,
//   });

//   final String? hintText;
//   final Widget? prefix;
//   final Widget? suffixIcon;
//   final bool isPassWord;
//   final bool readOnly;
//   final bool isEmail;
//   final TextInputAction? textInputAction;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final Color? fillColor;
//   final bool filled;
//   final double elevation;
//   final Color? elevationColor;
//   final int minLines;
//   final int? maxLines;
//   final InputBorder? border;
//   final InputBorder? errBorder;
//   final double? borderRadius;
//   final EdgeInsetsGeometry? contentPadding;
//   final TextStyle? style;
//   final BoxConstraints? prefixIconConstraints;
//   final BoxConstraints? suffixIconConstraints;
//   final void Function(String)? onFieldSubmitted;
//   final void Function()? onTap;
//   final void Function(String)? onChanged;
//   final TextAlignVertical? textAlignVertical;
//   final bool isPassWordSecondValidation;
//   final bool isOptional;
//   final TextEditingController? isPassWordSecondValidationController;

//   @override
//   State<AppInputWidgetTwo> createState() => _AppInputWidgetTwoState();
// }

// class _AppInputWidgetTwoState extends State<AppInputWidgetTwo> {
//   bool isShowPassWord = true;
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: widget.elevation,
//       shadowColor: widget.elevationColor,
//       borderOnForeground: false,
//       color: Colors.transparent,
//       borderRadius: BorderRadius.circular(
//         AppSize.width(value: widget.borderRadius ?? 8.0),
//       ),
//       child: TextFormField(
//         onChanged: widget.onChanged,
//         onTap: widget.onTap,
//         onFieldSubmitted: widget.onFieldSubmitted,
//         readOnly: widget.readOnly,
//         controller: widget.controller,
//         minLines: widget.minLines,
//         maxLines: widget.maxLines,
//         validator: (value) {
//           if (widget.isOptional) {
//             return null;
//           }
//           if (value == null || value.isEmpty) {
//             return "This field is required";
//           }
//           if (widget.isPassWord && value.length < 8) {
//             return "Must be at last 8 characters.";
//           }
//           if (widget.isEmail) {
//             const pattern =
//                 r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
//                 r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
//                 r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
//                 r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
//                 r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
//                 r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
//                 r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
//             final regex = RegExp(pattern);
//             if (regex.hasMatch(value)) return null;
//             return "Please provide valid email address";
//           }
//           if (widget.isPassWord && widget.isPassWordSecondValidation) {
//             if (widget.isPassWordSecondValidationController != null) {
//               if (value.toLowerCase() !=
//                   widget.isPassWordSecondValidationController!.text
//                       .toLowerCase()) {
//                 return "Both passwords most match";
//               } else {
//                 return null;
//               }
//             }
//           }

//           return null;
//         },
//         keyboardType: widget.keyboardType,
//         textInputAction: widget.textInputAction,
//         obscureText: widget.isPassWord && isShowPassWord,
//         obscuringCharacter: "*",
//         textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
//         style:
//             widget.style ??
//              TextStyle(
//               height: 2,
//               fontFamily: AppConst.fontFamily1,
//               fontWeight: FontWeight.w500,
//               color: AppColors.instance.black400,
//             ),
//         decoration: InputDecoration(
//           errorStyle: TextStyle(backgroundColor: AppColors.instance.white50),
//           contentPadding:
//               widget.contentPadding ??
//               EdgeInsets.all(AppSize.width(value: 10.0)),
//           filled: widget.filled,
//           fillColor:
//               widget.fillColor ?? AppColors.instance.white50.withValues(alpha: .3),
//           prefixIcon: widget.prefix,

//           suffixIcon:
//               widget.isPassWord
//                   ? IconButton(
//                     color: AppColors.instance.white400,
//                     padding: EdgeInsets.zero,
//                     iconSize: 16,
//                     highlightColor: AppColors.instance.white500,
//                     onPressed: () {
//                       setState(() {
//                         isShowPassWord = !isShowPassWord;
//                       });
//                     },
//                     icon:
//                         isShowPassWord
//                             ? const Icon(Icons.visibility)
//                             : const Icon(Icons.visibility_off),
//                   )
//                   : widget.suffixIcon,
//           hintText: widget.hintText,
//           hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
//             color: AppColors.instance.white400.withValues(alpha: .8),
//           ),
//           prefixIconConstraints:
//               widget.prefixIconConstraints ??
//               BoxConstraints(
//                 maxWidth: AppSize.width(value: 40),
//                 maxHeight: AppSize.width(value: 40),
//               ),
//           suffixIconConstraints:
//               widget.suffixIconConstraints ??
//               BoxConstraints(
//                 maxWidth: AppSize.width(value: 40),
//                 maxHeight: AppSize.width(value: 40),
//               ),
//           border:
//               widget.border ??
//               OutlineInputBorder(
//                 // borderSide: BorderSide(color: AppColors.primary200),
//                 borderRadius: BorderRadius.circular(
//                   AppSize.width(value: widget.borderRadius ?? 8.0),
//                 ),
//               ),
//           enabledBorder:
//               widget.border ??
//               OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColors.instance.white50),
//                 borderRadius: BorderRadius.circular(
//                   AppSize.width(value: widget.borderRadius ?? 8.0),
//                 ),
//               ),
//           focusedBorder:
//               widget.border ??
//               OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColors.instance.white50),
//                 borderRadius: BorderRadius.circular(
//                   AppSize.width(value: widget.borderRadius ?? 8.0),
//                 ),
//               ),
//           errorBorder:
//               widget.errBorder ??
//               OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColors.instance.white50),
//                 borderRadius: BorderRadius.circular(
//                   AppSize.width(value: widget.borderRadius ?? 8.0),
//                 ),
//               ),
//           focusedErrorBorder:
//               widget.errBorder ??
//               OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColors.instance.white50),
//                 borderRadius: BorderRadius.circular(
//                   AppSize.width(value: widget.borderRadius ?? 8.0),
//                 ),
//               ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/app_const.dart';
import 'package:luggage_tracking/utils/app_size.dart';

class AppInputWidgetTwo extends StatefulWidget {
  const AppInputWidgetTwo({
    super.key,
    this.hintText,
    this.prefix,
    this.suffixIcon,
    this.isPassWord = false,
    this.isEmail = false,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.keyboardType,
    this.fillColor,
    this.elevation = 0.0,
    this.elevationColor,
    this.minLines = 1,
    this.readOnly = false,
    this.border,
    this.errBorder,
    this.borderRadius,
    this.contentPadding,
    this.style,
    this.maxLines,
    this.onFieldSubmitted,
    this.onTap,
    this.filled = true,
    this.prefixIconConstraints,
    this.textAlignVertical,
    this.suffixIconConstraints,
    this.onChanged,
    this.isPassWordSecondValidation = false,
    this.isOptional = false,
    this.isPassWordSecondValidationController,
  });

  final String? hintText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool isPassWord;
  final bool readOnly;
  final bool isEmail;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final bool filled;
  final double elevation;
  final Color? elevationColor;
  final int minLines;
  final int? maxLines;
  final InputBorder? border;
  final InputBorder? errBorder;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextAlignVertical? textAlignVertical;
  final bool isPassWordSecondValidation;
  final bool isOptional;
  final TextEditingController? isPassWordSecondValidationController;

  @override
  State<AppInputWidgetTwo> createState() => _AppInputWidgetTwoState();
}

class _AppInputWidgetTwoState extends State<AppInputWidgetTwo> {
  bool isShowPassWord = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      shadowColor: widget.elevationColor,
      borderOnForeground: false,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(
        AppSize.width(value: widget.borderRadius ?? 8.0),
      ),
      child: TextFormField(
        cursorColor: AppColors.instance.white600,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,
        readOnly: widget.readOnly,
        controller: widget.controller,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        validator: (value) {
          if (widget.isOptional) return null;
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          if (widget.isPassWord && value.length < 8) {
            return "Must be at last 8 characters.";
          }
          if (widget.isEmail) {
            const pattern =
                r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f'
                r'\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
            final regex = RegExp(pattern);
            if (regex.hasMatch(value)) return null;
            return "Please provide valid email address";
          }
          if (widget.isPassWord && widget.isPassWordSecondValidation) {
            if (widget.isPassWordSecondValidationController != null) {
              if (value.toLowerCase() !=
                  widget.isPassWordSecondValidationController!.text
                      .toLowerCase()) {
                return "Both passwords most match";
              }
            }
          }
          return null;
        },
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.isPassWord && isShowPassWord,
        obscuringCharacter: "*",
        textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
        style:
            widget.style ??
            TextStyle(
              height: 2,
              fontFamily: AppConst.fontFamily1,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.black400,
            ),
        decoration: InputDecoration(
          labelText: widget.hintText, // floating label
          labelStyle: TextStyle(
            fontSize: AppSize.width(value: 14),
            color: AppColors.instance.black400,
            fontFamily: AppConst.fontFamily1,
          ),

          // hint text (will be replaced by label when focused)
          hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.instance.black400.withOpacity(0.5),
          ),
          filled: true,
          fillColor: AppColors.instance.white200, // fill color white
          contentPadding:
              widget.contentPadding ??
              EdgeInsets.symmetric(vertical: 12, horizontal: 12),

          suffixIcon:
              widget.isPassWord
                  ? IconButton(
                    color: AppColors.instance.black400,
                    padding: EdgeInsets.zero,
                    iconSize: 16,
                    onPressed: () {
                      setState(() {
                        isShowPassWord = !isShowPassWord;
                      });
                    },
                    icon:
                        isShowPassWord
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                  )
                  : widget.suffixIcon,
          prefixIconConstraints:
              widget.prefixIconConstraints ??
              const BoxConstraints(maxWidth: 40, maxHeight: 40),
          suffixIconConstraints:
              widget.suffixIconConstraints ??
              const BoxConstraints(maxWidth: 40, maxHeight: 40),

          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.instance.white600),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.instance.white600),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.instance.white600),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.instance.red1),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.instance.red1),
          ),
        ),
      ),
    );
  }
}
