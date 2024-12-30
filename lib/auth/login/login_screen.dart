import 'package:event_planning/auth/register/register_screen.dart';
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


class LoginScreen extends StatelessWidget {
  static const String routeName = 'Login Screen';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height * 0.05670,),
            Image.asset(AssetsManager.logo,height: height * 0.22,),
            SizedBox(height:  height * 0.0285,),
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
            SizedBox(height: height * 0.019,),
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
            SizedBox(height: height * 0.019,),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04
              ),
              child: Text(AppLocalizations.of(context)!.forget_password,
                  textAlign: TextAlign.end,
                  style:AppStyles.bold16Primary.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryLight
                  ),
                ),
            ),
            SizedBox(height: height * 0.02,),
            Padding(padding: EdgeInsets.symmetric(
              horizontal: width * 0.04
            ),
              child: CustomElevatedButton(
                onButtonClicked: (){
                  Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                },
                buttonText: AppLocalizations.of(context)!.login,
              ),
            ),
            SizedBox(height: height * 0.02,),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RegisterScreen.routeName);
              },
              child: Text.rich(
                textAlign: TextAlign.center,
                  TextSpan(
                children: [
                  TextSpan(text: AppLocalizations.of(context)!.dont_have_account,
                      style: themeProvider.appTheme == ThemeMode.light ?
                  AppStyles.medium16Black : AppStyles.medium16White),
                  TextSpan(text: AppLocalizations.of(context)!.create_account,
                      style: AppStyles.bold16Primary)
                ]
              )),
            ),
            SizedBox(height: height * 0.02,),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: AppColors.primaryLight,
                    indent: width * 0.1,
                    endIndent: width * 0.04,
                  ),
                ),
                Text(AppLocalizations.of(context)!.or,
                    style: AppStyles.medium16Primary,),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: AppColors.primaryLight,
                    endIndent: width * 0.1,
                    indent: width * 0.04,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03,),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04
              ),
              child: CustomElevatedButton(
                onButtonClicked: (){},
                buttonText: AppLocalizations.of(context)!.login_with_google,
                textStyle: AppStyles.medium20Primary,
                backgroundColor: themeProvider.appTheme == ThemeMode.light ?
                AppColors.whiteColor : AppColors.primaryDark,
                prefixIconButton: Image.asset(AssetsManager.googleIcon),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
