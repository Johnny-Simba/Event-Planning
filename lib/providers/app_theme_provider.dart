import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppThemeProvider extends ChangeNotifier{
  bool? isDarkTheme;
  ThemeMode? appTheme = ThemeMode.light;


  void changeTheme(ThemeMode newTheme){
    if(appTheme == newTheme){
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }
  Future<void> getSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    appTheme = isDarkTheme! ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

}