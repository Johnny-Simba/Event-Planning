import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabEventWidget extends StatelessWidget {
  bool isSelected;
  String eventName;
  TabEventWidget({required this.isSelected, required this.eventName});

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
          color: AppColors.whiteColor,
          width: 2,
        ),
        color: isSelected ? AppColors.whiteColor : AppColors.transparentColor,
      ),
      child: Text(eventName,
        style: isSelected ? themeProvider.appTheme == ThemeMode.light ? AppStyles.medium16Primary :
        AppStyles.medium16PrimaryDark : AppStyles.medium16White,
        ),
    );
  }
}
