import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
typedef MyValidator = String? Function(String?)?;

class CustomTextField extends StatelessWidget {
  Color borderColor ;
  String hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  TextStyle? style;
  int? maxLines;
  TextEditingController? controller;
  Widget? prefixIcon;
  MyValidator validator;
  Widget? suffixIcon;
  bool obscureText;
  CustomTextField({this.borderColor = AppColors.grayColor, required this.hintText,
    this.labelText, this.hintStyle, this.prefixIcon, this.suffixIcon, this.labelStyle,
  this.style, this.obscureText = false, this.maxLines, this.validator,
    this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      obscuringCharacter: '*',
      cursorColor: AppColors.blackColor,
      maxLines: maxLines ?? 1,
      style: style ?? AppStyles.medium16Black,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        labelStyle: labelStyle,
        suffixIcon: suffixIcon,
        hintStyle: hintStyle ?? AppStyles.medium16Gray,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor,
            width: 2
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: borderColor,
              width: 2
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: AppColors.redColor,
                width: 2
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: AppColors.redColor,
                width: 2
            )
        ),
      ),
    );
  }
}
