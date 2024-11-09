import 'package:communihelp_app/Databases/HiveServices/hive_db_settings.dart';
import 'package:communihelp_app/ViewModel/theme.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserSettingViewModel extends ChangeNotifier{
  Logger logger = Logger();

  //access local HiveServices
  HiveDbSettings dbSettings = HiveDbSettings();


  //Language
  String userLanguage = "En"; //SYSTEM check for this


 //for theme
 ThemeData _themeData = lightMode;
 ThemeData _darktTheme = darktMode;

 bool isLightMode = false;
 bool isDarkMode = false;

 

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


  //sets if light or dark
 void setThemeToBool(Brightness currentTheme) {
  logger.i("Called");
  //sets for storage
  if (currentTheme == Brightness.light && !dbSettings.userSettings["isDefault"]) {
    isLightMode = true;
    isDarkMode = false;
    toggleTheme();
    notifyListeners();
    logger.i("Light mode!");
  }
  else if (currentTheme == Brightness.dark && !dbSettings.userSettings["isDefault"]){
    isLightMode = false;
    isDarkMode = true;
    toggleTheme();
    notifyListeners();
    logger.i("Dark mode!");
  }
  else {
    isLightMode = true;
    isDarkMode = false;
    toggleTheme();
    notifyListeners();
    logger.i("Light mode!");
  }
 }

  //changes theme state
 void toggleTheme() {
  logger.i("Called theme change");
  if (_themeData == lightMode && isLightMode) {
    themeData = darktMode;
    darktTheme = lightMode;
    logger.i("Changed to darkmode");
  }
  else {
    themeData = lightMode;
    darktTheme = darktMode;
    logger.i("Changed to lightmode");
  }
 }

  //loads from hive 
 void loadSettings(String uid) {
  dbSettings.loadData(uid);
  userLanguage = dbSettings.userSettings["language"];
  isLightMode = dbSettings.userSettings["lightmode"];
  isDarkMode = dbSettings.userSettings["darkmode"]; 
 }

  //add to local hive
  void addPreference(String uid) {
    dbSettings.addUserSettings(userLanguage, isLightMode, isDarkMode, false);
  }

  //calls to put data to box
  void updateDB(String uid) {
    dbSettings.updateData(uid);
  }
  

  void changeLanguag(String currentOption) {
    userLanguage = currentOption;
    notifyListeners();
  }
}

class Language {
  Map systemLang = {};

  Language(String userLanguage) {
    if (userLanguage.toLowerCase() == "en") {
      systemLang = getEnglish();
    }
    else if (userLanguage.toLowerCase() == "fil") {
      systemLang = getFilipino();
    }
    else if (userLanguage.toLowerCase() == "akl") {
      systemLang = getAkl();
    }
  }

  Map getEnglish() {
    return {
        "Settings" : {
          "DisplaySetting" : "Display setting",
          "SwitchLightMode" : "Switch to light mode",
          "SwitchDarkMode" : "Switch to dark mode",
          "Preffered": "Preferred Language"
        },
        "Home" : {
          "Announcement" : "Announcements",
          "NaturalDis" : "Natural Disasters",
          "ManmadeDis" : "Man-made Disasters",
          "SearchEvac" : "Search for Evacuation Center",
          "News" : "View News",
          "Weather" : "View Weather",
          "Kit" : "My Kits",
          "ReportLabel" : "Send a report",
          "Report" : "Report" 
        }
    };
  }

  Map getFilipino() {
    return {
      "Settings" : {
        "DisplaySetting" : "Setting ng Display",
        "SwitchLightMode" : "Lumipat sa light mode",
        "SwitchDarkMode" : "Lumipat sa  dark mode",
        "Preffered": "Piniling Wika"
      },
      "Home" : {
          "Announcement" : "Mga Anunsyo",
          "NaturalDis" : "Natural na Sakuna",
          "ManmadeDis" : "Sakunang Gawa-tao",
          "SearchEvac" : "Maghanap ng Evacuation Center",
          "News" : "Mga Balita",
          "Weather" : "Anv Panahon",
          "Kit" : "Aking Kits",
          "ReportLabel" : "Magpadala ng ulat",
          "Report" : "Report" 
        }
    };
  }

  Map getAkl() {
    return {
      "Settings" : {
        "DisplaySetting" : "Setting it Display",
        "SwitchLightMode" : "Ihalin sa light mode",
        "SwitchDarkMode" : "Ihalin sa light mode",
        "Preffered": "Pinili nga Wika"
      },
      "Home" : {
          "Announcement" : "Mga Anunsyo",
          "NaturalDis" : "Natural na Sakuna",
          "ManmadeDis" : "Sakunang Gawa-tao",
          "SearchEvac" : "Magusoy ng Evacuation Center",
          "News" : "Mga Balita",
          "Weather" : "Anv Panahon",
          "Kit" : "Akong Kits",
          "ReportLabel" : "Magpadaea it ulat",
          "Report" : "Report" 
        }
    };
  }
}

// abstract class Language {
//   void display();

//   factory Language(String language) {
//     if (language.toLowerCase() == "en") {
//       return EnglishLang();
//     }
//     else if (language.toLowerCase() == "fil") {
//       return FiliLang();
//     }
//     else {
//       throw ArgumentError("Invalid language");
//     }
//   }
// }

// class EnglishLang implements Language {
//   final Map translationEn1 = {
//     "Settings" : {
//       "DisplaySetting" : "Display setting",
//       "SwitchLightMode" : "Switch to light mode",
//       "SwitchDarkMode" : "Switch to dark mode",
//       "Preffered": "Preferred Language"
//     }
//   };

//   @override
//   void display() {
//     print("Im english");
//   }
  
// }

// class FiliLang implements Language{
//   final Map translationEn1 = {
//     "Settings" : {
//       "DisplaySetting" : "",
//       "SwitchLightMode" : "Lumipat sa light mode",
//       "SwitchDarkMode" : "Lumipat sa  dark mode",
//       "Preffered": "Piniling Wika"
//     }
//   };

//   @override
//   void display() {
//     print("Im filipino");
//   }
// }


