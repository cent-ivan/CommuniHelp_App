import 'package:communihelp_app/ViewModel/theme.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserSettingViewModel extends ChangeNotifier{
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

  //Language
  String userLanguage = "En";
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


