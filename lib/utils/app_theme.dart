import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    primaryColor: AppColors.primaryLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        unselectedLabelStyle: AppStyles.bold12White,
        selectedLabelStyle: AppStyles.bold12White,
        elevation: 0
      ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(
          color: AppColors.whiteColor,
          width: 4,
        ),
      )
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight
    )
  );

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.primaryDark,
    primaryColor: AppColors.primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      unselectedLabelStyle: AppStyles.bold12White,
      selectedLabelStyle: AppStyles.bold12White,
      elevation: 0
    ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(
              color: AppColors.whiteColor,
              width: 4,
            ),
          )
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryDark
      )
  );
}