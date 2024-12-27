import 'package:event_planning/auth/login/login_screen.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/home_screen.dart';
import 'package:event_planning/ui/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RegisterScreen extends StatelessWidget {
  static const String routeName = 'Register Screen';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register,
          style: themeProvider.appTheme == ThemeMode.light ?
          AppStyles.regular20Black : AppStyles.regular20White,),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, size: 24,
              color: themeProvider.appTheme ==
                  ThemeMode.dark ? AppColors.whiteColor : AppColors.blackColor),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AssetsManager.logo,height: height * 0.22,),
          CustomTextField(
            hintText: AppLocalizations.of(context)!.name,
            hintStyle: themeProvider.appTheme == ThemeMode.light ?
            AppStyles.medium16Gray : AppStyles.medium16White,
            style: themeProvider.appTheme == ThemeMode.light ?
            AppStyles.medium16Black : AppStyles.medium16White,
            borderColor: themeProvider.appTheme == ThemeMode.light ?
            AppColors.grayColor : AppColors.whiteColor,
            prefixIcon: ImageIcon(AssetImage(AssetsManager.profileIcon),size: 24,
              color: themeProvider.appTheme == ThemeMode.light ?
              AppColors.grayColor : AppColors.whiteColor,),
          ),
          CustomTextField(
              hintText: AppLocalizations.of(context)!.email,
            hintStyle: themeProvider.appTheme == ThemeMode.light ?
            AppStyles.medium16Gray : AppStyles.medium16White,
            style: themeProvider.appTheme == ThemeMode.light ?
            AppStyles.medium16Black : AppStyles.medium16White,
            borderColor: themeProvider.appTheme == ThemeMode.light ?
            AppColors.grayColor : AppColors.whiteColor,
            prefixIcon: ImageIcon(AssetImage(AssetsManager.emailIcon),size: 24,
              color: themeProvider.appTheme == ThemeMode.light ?
              AppColors.grayColor : AppColors.whiteColor,),
          ),
          CustomTextField(
            hintText: AppLocalizations.of(context)!.password,
            obscureText: true,
            hintStyle: themeProvider.appTheme == ThemeMode.light ?
            AppStyles.medium16Gray : AppStyles.medium16White,
            borderColor: themeProvider.appTheme == ThemeMode.light ?
            AppColors.grayColor : AppColors.whiteColor,
            prefixIcon: ImageIcon(AssetImage(AssetsManager.passwordIcon),size: 24,
              color: themeProvider.appTheme == ThemeMode.light ?
              AppColors.grayColor : AppColors.whiteColor,),
            suffixIcon: ImageIcon(AssetImage(AssetsManager.hidePasswordIcon),size: 24,
              color: themeProvider.appTheme == ThemeMode.light ?
              AppColors.grayColor : AppColors.whiteColor,),
          ),
          CustomTextField(
            hintText: AppLocalizations.of(context)!.re_password,
            obscureText: true,
            hintStyle: themeProvider.appTheme == ThemeMode.light ?
            AppStyles.medium16Gray : AppStyles.medium16White,
            borderColor: themeProvider.appTheme == ThemeMode.light ?
            AppColors.grayColor : AppColors.whiteColor,
            prefixIcon: ImageIcon(AssetImage(AssetsManager.passwordIcon),size: 24,
              color: themeProvider.appTheme == ThemeMode.light ?
              AppColors.grayColor : AppColors.whiteColor,),
            suffixIcon: ImageIcon(AssetImage(AssetsManager.hidePasswordIcon),size: 24,
              color: themeProvider.appTheme == ThemeMode.light ?
              AppColors.grayColor : AppColors.whiteColor,),
          ),
          SizedBox(height: height * 0.02,),
          Padding(padding: EdgeInsets.symmetric(
            horizontal: width * 0.04
          ),
            child: CustomElevatedButton(
              onButtonClicked: (){},
              buttonText: AppLocalizations.of(context)!.create_account,
            ),
          ),
          SizedBox(height: height * 0.02,),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text.rich(
              textAlign: TextAlign.center,
                TextSpan(
              children: [
                TextSpan(text: AppLocalizations.of(context)!.already_have_account,
                    style: themeProvider.appTheme == ThemeMode.light ?
                AppStyles.medium16Black : AppStyles.medium16White),
                TextSpan(text: AppLocalizations.of(context)!.login,
                    style: AppStyles.bold16Primary)
              ]
            )),
          ),
        ],
      ),
    );
  }
}
