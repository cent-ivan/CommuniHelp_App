import 'package:communihelp_app/Databases/HiveServices/hive_db_settings.dart';
import 'package:communihelp_app/ViewModel/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserSettingViewModel extends ChangeNotifier{
  Logger logger = Logger();

  //access local HiveServices
  HiveDbSettings dbSettings = HiveDbSettings();

  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;


  //Language
  String userLanguage = "En"; //SYSTEM check for this


 //for theme
 ThemeData themeData = lightMode;
 ThemeData darktTheme = darktMode;

 bool isLightMode = true;

 UserSettingViewModel() {
  loadSettings(curUser!.uid);
 }



  //changes theme state
 void toggleTheme() {
  if (isLightMode) {
    themeData = lightMode;
    darktTheme = darktMode;
    
    isLightMode = false;
    notifyListeners();
    logger.i("Changed to darkmode");
  }
  else {
    themeData = darktMode;
    darktTheme = lightMode;
    isLightMode = true;
    notifyListeners();
    logger.i("Changed to lightmode");
  }
 }

  //loads from hive 
 void loadSettings(String uid) {
  dbSettings.loadData(uid);
  userLanguage = dbSettings.userSettings['language']; //dbSettings.userSettings["language"];
  isLightMode = dbSettings.userSettings['isLightmode'];//dbSettings.userSettings["lightmode"];
  //sets the users preference
  if (!isLightMode) {
    themeData = lightMode;
    darktTheme = darktMode;
  }
  else {
    themeData = darktMode;
    darktTheme = lightMode;
  }
 }

  //add to local hive
  void addPreference(String uid) {
    dbSettings.addUserSettings(userLanguage, isLightMode, false);
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
        },
        "NaturalInfo" : {
          "NaturalTitle" : "Natural Disasters",
          "Definition" : "Natural disasters, such as typhoons, earthquakes, floods, landslide, and many more, can cause widespread devastation and loss of life. These events are often unpredictable and can occur suddenly, leaving communities with little time to prepare.",
          "Types" : "Types of Natural Disasters",
          "TyButton" : "Typhoon",
          "FloodButton" : "Flood",
          "LandButton" : "Landslide",
          "EarthButton" : "Earthquake"
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
        },
      "NaturalInfo" : {
        "NaturalTitle" : "Mga likas na sakuna",
        "Definition" : "Ang mga likas na sakuna, tulad ng bagyo, lindol, baha, pagguho ng lupa, at marami pang iba, ay maaaring magdulot ng matinding pinsala at pagkawala ng buhay. Kadalasan, hindi tiyak kung kailan ito mangyayari at nagiging banta sa komunidad.",
        "Types" : "Uri ng likas na sakuna",
        "TyButton" : "Bagyo",
        "FloodButton" : "Baha",
        "LandButton" : "Pagguho ng lupa",
        "EarthButton" : "Lindol"
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


