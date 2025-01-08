import 'package:event_planning/auth/login/login_screen.dart';
import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/model/my_user.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/home_screen.dart';
import 'package:event_planning/ui/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:event_planning/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers/event_list_provider.dart';
import '../../providers/user_provider.dart';


class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'youssef');

  var emailController = TextEditingController(text: 'youssef@gmail.com');

  var passwordController = TextEditingController(text: '123456');

  var rePasswordController = TextEditingController(text: '123456');

  late EventListProvider eventListProvider;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register,
          style: themeProvider.appTheme == ThemeMode.light ?
          AppStyles.regular20Black : AppStyles.regular20White,),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: themeProvider.appTheme ==
              ThemeMode.dark ? AppColors.whiteColor : AppColors.blackColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AssetsManager.logo,height: height * 0.22,),
              CustomTextField(
                controller: nameController,
                validator: (text) {
                    if(text == null || text.trim().isEmpty){
                      return 'Please Enter Name';
                    }
                    return null;
                },
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
              SizedBox(height: height * 0.019,),
              CustomTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return 'Please Enter Email';
                  }
                  final bool emailValid =
                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if(!emailValid){
                    return 'Please Enter Valid Email';
                  }
                  return null;
                },
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
                controller: passwordController,
                keyboardType: TextInputType.number,
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return 'Please Enter Password';
                  }
                  if(text.length < 6){
                    return 'Password should be at least 6 chars';
                  }
                  return null;
                },
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
              CustomTextField(
                controller: rePasswordController,
                keyboardType: TextInputType.phone,
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return 'Please Enter Re-Password';
                  }
                  if(text != passwordController.text){
                    return "Re-Password doesn't match Password.";
                  }
                  return null;
                },
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
                  onButtonClicked: (){
                    register();
                  },
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
        ),
      ),
    );
  }

  void register() async{
    if(formKey.currentState?.validate() == true){
      DialogUtils.showLoading(context: context, message: 'Loading....');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? "",
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: 'Register Successfully.',
        title: 'Success', posActionName: 'Ok', posAction: (){
          eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'The password provided is too weak.',
          title: 'Error', posActionName: 'Ok');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'The account already exists for that email.',
          title: 'Error', posActionName: 'Ok');
        } else if(e.code == 'network-request-failed'){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context,
              message: 'A network error (such as timeout, interrupted connection or unreachable host) has occurred',
              title: 'Error', posActionName: 'Ok');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: e.toString(),
        title: 'Error', posActionName: 'Ok');
      }
    }
  }
}
