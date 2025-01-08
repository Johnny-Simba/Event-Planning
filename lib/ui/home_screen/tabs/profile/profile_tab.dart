import 'package:event_planning/auth/login/login_screen.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/language_bottom_sheet.dart';
import 'package:event_planning/ui/home_screen/tabs/theme_bottom_sheet.dart';
import 'package:event_planning/ui/widget/custom_elevated_button.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTap extends StatefulWidget {

  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryLight,
            toolbarHeight: height * 0.18549,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))
            ),
            title: Row(
              children: [
                Image.asset(AssetsManager.routeImage),
                SizedBox(width: width * 0.04,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Route Academy',style: AppStyles.bold24White,),
                    Text('route@gmail.com',style: AppStyles.medium16White,),
                  ],
                )
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:  width * 0.04,
              vertical: height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.language,
                  style: themeProvider.appTheme == ThemeMode.light ? AppStyles.bold20Black :
                  AppStyles.bold20White,),
                SizedBox(height: height*0.019,),
                InkWell(
                  onTap: (){
                    showLanguageBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryLight,
                        width: 2
                      )
                    ),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(languageProvider.appLanguage == 'en'?
                          AppLocalizations.of(context)!.english:
                          AppLocalizations.of(context)!.arabic,
                        style: AppStyles.bold20Primary,),
                        Icon(Icons.arrow_drop_down,size: 35,color: AppColors.blueColor,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height*0.019,),
                Text(AppLocalizations.of(context)!.theme,
                    style: themeProvider.appTheme == ThemeMode.light ? AppStyles.bold20Black :
                    AppStyles.bold20White,),
                SizedBox(height: height*0.019,),
                InkWell(
                  onTap: (){
                    showThemeBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColors.primaryLight,
                            width: 2
                        )
                    ),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(themeProvider.appTheme == ThemeMode.dark?
                        AppLocalizations.of(context)!.dark:
                        AppLocalizations.of(context)!.light,
                          style: AppStyles.bold20Primary,),
                        Icon(Icons.arrow_drop_down,size: 35,color: AppColors.blueColor,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.29,),
                CustomElevatedButton(
                  onButtonClicked: (){
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.disconnect();
                    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                  },
                  buttonText: AppLocalizations.of(context)!.logout,
                  prefixIconButton: Icon(Icons.logout, color: AppColors.whiteColor,size: 24,),
                  mainAxisAlignment: MainAxisAlignment.start,
                  backgroundColor: AppColors.redColor,
                )
              ],
            ),
          ),
        );
  }
  void showLanguageBottomSheet() {
    showModalBottomSheet(context: context,
      builder: (context) {
        return LanguageBottomSheet();
      },);
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(context: context,
      builder: (context) {
        return ThemeBottomSheet();
      },);
  }


}
