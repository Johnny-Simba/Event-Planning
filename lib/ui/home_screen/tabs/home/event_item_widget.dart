import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventItemWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.01,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01
      ),
      height: height * 0.241,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryLight,
          width: 1,
        ),
        image: DecorationImage(image: AssetImage(AssetsManager.birthdayImage),fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.01,
            ),
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: themeProvider.appTheme == ThemeMode.light ?
                  AppColors.whiteColor : AppColors.primaryDark,
            ),
            child: Column(
              children: [
                Text('21',style: AppStyles.bold20Primary,),
                Text('Nov',style: AppStyles.bold14Primary)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.011890
            ),
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.009,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: themeProvider.appTheme == ThemeMode.light ?
              AppColors.whiteColor : AppColors.primaryDark,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('This is a Birthday Party ',style: themeProvider.appTheme == ThemeMode.light ?
                AppStyles.bold14Black : AppStyles.bold14White,),
                ImageIcon(AssetImage(AssetsManager.iconLove),color: AppColors.primaryLight,size: 24,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
