import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  Color borderColor ;
  String hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  TextStyle? style;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;
  CustomTextField({this.borderColor = AppColors.grayColor, required this.hintText,
    this.labelText, this.hintStyle, this.prefixIcon, this.suffixIcon, this.labelStyle,
  this.style, this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        obscureText: obscureText,
        obscuringCharacter: '*',
        cursorColor: AppColors.blackColor,
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
      ),
    );
  }
}
