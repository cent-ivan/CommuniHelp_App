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
  isLightMode = dbSettings.userSettings["isLightmode"];//dbSettings.userSettings["lightmode"];
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
        },
        "ManmadeInfo" : {
        "Title" : "Man-made Disaster",
        "Definition" : "A man-made disaster can strike with devastating consequences, often stemming from human error, negligence, or intentional harm.",
        "Types" : "Kinds of Man-made disasters",
        "Accident" : "Vehicular Incident",
        "Fire" : "Fire related disaster",
        "Failure" : "Structural Failures",
        "Pollution" : "Water Pollution"
      },
        "Contact" : {
          "Label" : "My Contact List",
          "Search" : "Search"
        },
        "Forum" : {
          "PostButton" : "Share a thought",
          "Offline" : "Offline mode. Cannot Post and Like",
          "DialogTitle" : "Share a thought",
          "from" : "from ",
          "FieldTitle" : "Enter post title",
          "Content" : "What's on your mind?",
          "BlankTitle" : "Enter a title first",
          "BlankContent" : "Post is blank"
        },
        "Profile" : {
          "ProfileLabel" : "My Profile",
          "details" : "Personal Details",
          "contactdet" : "Contact Details",
          "fullname" : "Full Name",
          "gender" : "Gender",
          "birthday" : "Birthdate",
          "edit": "Edit Profile",
          "nonet": "No Internet. Cannot Edit",
          "changeemail" : "Change email here",
          "changepass" : "Change password here"
        },
        "Emergency" : {
          "host" : "List of Hostpitals",
          "fire" : "Number of Fire Rescuer",
          "coast" : "Number of Coastguard"
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
          "ManmadeDis" : "Sakunang Gawang-tao",
          "SearchEvac" : "Maghanap ng Evacuation Center",
          "News" : "Mga Balita",
          "Weather" : "Ang Panahon",
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
      },
      "ManmadeInfo" : {
        "Title" : "Mga sakunang likha ng tao",
        "Definition" : "Ang isang sakunang likha ng tao ay maaaring magdulot ng matinding pinsala, na kadalasang nagmumula sa pagkakamali, kapabayaan, o sinadyang pananakit ng tao.",
        "Types" : "Uri ng sakunang likha ng tao",
        "Accident" : "Aksidente sa sasakyan",
        "Fire" : "Sunog",
        "Failure" : "Pagbagsak ng estruktura",
        "Pollution" : "Polusyon sa tubig"
      },
      "Contact" : {
          "Label" : "Aking Kontaks",
          "Search" : "Hanapin"
        },
      "Forum" : {
          "PostButton" : "Magbahagi ng saloobin",
          "Offline" : "Offline mode. Hindi maka-Post at Like",
          "DialogTitle" : "Magbahagi ng saloobin",
          "from" : "taga-",
          "FieldTitle" : "Maglagay ng titulo",
          "Content" : "Ano nasa isip mo?",
          "BlankTitle" : "Maglagay ng titulo",
          "BlankContent" : "Walang laman ang post"
      },
      "Profile" : {
          "ProfileLabel" : "Aking profile",
          "details" : "Personal na Impormasyon",
          "contactdet" : "Mga detalye ng Contact",
          "fullname" : "Buong Pangalan",
          "gender" : "Kasarian",
          "birthday" : "Kaarawan",
          "edit": "Baguhin ang profile",
          "nonet": "Walang Internet.",
          "changeemail" : "Bagohin ang email",
          "changepass" : "Bagohin ang password"
        },
      "Emergency" : {
          "host" : "Listahan ng mga ostpital",
          "fire" : "Numero ng Bombero",
          "coast" : "Numero ng Coastguard"
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
          "Weather" : "Ang Panahon",
          "Kit" : "Akong Kits",
          "ReportLabel" : "Magpadaea it ulat",
          "Report" : "Report" 
        },
        "Contact" : {
          "Label" : "Akong Kontaks",
          "Search" : "Pangitaon"
        },
        "Forum" : {
          "PostButton" : "Magbahagi ng saloobin",
          "Offline" : "Offline mode. Hindi maka-Post at Like",
          "DialogTitle" : "Magbahagi ng saloobin",
          "from" : "taga-",
          "FieldTitle" : "Magbutang it titulo",
          "Content" : "Ano nasa isip mo?",
          "BlankTitle" : "Magbutang it titulo",
          "BlankContent" : "Uwa’t sulod ro post"
      },
      "Profile" : {
          "ProfileLabel" : "Akong profile",
          "details" : "Personal nga Impormasyon",
          "contactdet" : "Mga detalye it Contact",
          "fullname" : "Buo nga Pangalan",
          "gender" : "Kasarian",
          "birthday" : "Kaarawan",
          "edit": "Baguhon ang profile",
          "nonet": "Wa it Internet.",
          "changeemail" : "Bag-ohon ang email",
          "changepass" : "Bag-ohon ang password"
        },
        "Emergency" : {
          "host" : "Listahan it mga ostpital",
          "fire" : "Numero it Bombero",
          "coast" : "Numero it Coastguard"
        }
    };
  }
}



