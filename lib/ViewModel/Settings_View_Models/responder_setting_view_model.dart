import 'package:communihelp_app/ViewModel/theme.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ResponderSettingViewModel extends ChangeNotifier{
  Logger logger = Logger();

 //for theme
 ThemeData _themeData = lightMode;
 ThemeData _darktTheme = darktMode;

 ThemeData get themeData => _themeData;

 set themeData(ThemeData themeData) {
  _themeData = themeData;
  notifyListeners();
 }

 ThemeData get darktTheme => _darktTheme;

 set darktTheme(ThemeData darktTheme) {
  _darktTheme = darktTheme;
  notifyListeners();
 }


 void toggleTheme() {
  logger.i("Called theme change");
  if (_themeData == lightMode) {
    themeData = darktMode;
    darktTheme = lightMode;
  }
  else {
    themeData = lightMode;
    darktTheme = darktMode;
  }
 }

}