import 'package:event_planning/auth/register/register_screen.dart';
import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/home_screen.dart';
import 'package:event_planning/ui/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../model/my_user.dart';
import '../../utils/dialog_utils.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'youssef@gmail.com');

  var passwordController = TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * 0.05670,),
              Image.asset(AssetsManager.logo,height: height * 0.22,),
              SizedBox(height:  height * 0.0285,),
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
                    login();
                  },
                  buttonText: AppLocalizations.of(context)!.login,
                ),
              ),
              SizedBox(height: height * 0.02,),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
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
                  onButtonClicked: (){
                    // todo : Sign-in with Google
                    signInWithGoogle();
                  },
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
      ),
    );
  }

  void login() async{
    if(formKey.currentState?.validate() == true){
      try {
        DialogUtils.showLoading(context: context, message: 'Loading...');
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
        );
        var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid ?? "");
        if(user == null){
          return ;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: 'login successfully',
            title: 'Success', posActionName: 'Ok', posAction: (){
          eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print(credential.user?.uid??"");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'No user found for that email.',
              title: 'Error', posActionName: 'Ok');
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'Wrong password provided for that user.',
              title: 'Error', posActionName: 'Ok');
        }else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'This email not exist you should to create an account with this email.',
              title: 'Error', posActionName: 'Ok');
        } else if(e.code == 'network-request-failed'){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context,
              message: 'A network error (such as timeout, interrupted connection or unreachable host) has occurred',
              title: 'Error', posActionName: 'Ok');
        }
      }catch(e){
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: e.toString());
        print(e.toString());
      }
    }
  }
  Future signInWithGoogle() async {

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser == null){
      return ;
    }
    DialogUtils.showLoading(context: context, message: 'Loading...');
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    MyUser myUser = MyUser(
        id: googleUser!.id,
        name: googleUser.displayName ?? "",
        email: emailController.text);
    await FirebaseUtils.addUserToFireStore(myUser);
    await FirebaseUtils.readUserFromFireStore(myUser.id);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.updateUser(myUser);
    DialogUtils.hideLoading(context);
    DialogUtils.showMessage(context: context, message: 'login successfully',
        title: 'Success', posActionName: 'Ok', posAction: (){
          eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
  }


}

