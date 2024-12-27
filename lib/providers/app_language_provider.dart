import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier{
  bool? isEn;
  String appLanguage = 'en';

  void changeLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
  Future<void> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    isEn = prefs.getBool('isEn') ?? true;
    appLanguage = isEn! ? 'en' : 'ar';
    notifyListeners();
  }
}