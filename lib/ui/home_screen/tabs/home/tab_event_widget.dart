import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabEventWidget extends StatelessWidget {
  bool isSelected;
  String eventName;
  Color backgroundColor;
  TextStyle textSelectedStyle;
  TextStyle textUnSelectedStyle;
  Color? borderColor;
  TabEventWidget({required this.isSelected, required this.eventName,
    required this.backgroundColor, required this.textSelectedStyle,
    required this.textUnSelectedStyle, this.borderColor});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical:  height * 0.002
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: borderColor ?? AppColors.whiteColor,
          width: 2,
        ),
        color: isSelected ? backgroundColor : AppColors.transparentColor,
      ),
      child: Text(
        eventName,
        style: isSelected ? textSelectedStyle : textUnSelectedStyle,
        ),
    );
  }
}
