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
  isLightMode = dbSettings.userSettings['isLightmode'] ?? false; //if data is null auto null
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
          "NoAnnouncement" : "No Announcements",
          "PostAnnounce" : "Announcement",
          "NaturalDis" : "Natural Disasters",
          "ManmadeDis" : "Man-made Disasters",
          "SearchEvac" : "Search for Evacuation Center",
          "MarkEvac" : " Mark Evacuation Centers", //responder version
          "News" : "View News",
          "Weather" : "View Weather",
          "Kit" : "My Kits",
          "ReportLabel" : "Send a report",
          "ReportResp" : "See Reports", //reponder version
          "ReportRespButton" : "Reports", //reponder version
          "Report" : "Report" 
        },
        "MakeAnnounce" : {
          "AnnounceTitle" : "Make Announcements",
          "Today" : "Today",
          "Title" : "Title",
          "TitleHint" : "Enter Title",
          "Content" : "Content",
          "ContentHint" : "Enter announcement content",
          "Urgent" : "Important",
          "NoContent" : "Empty Text Fields, make sure you fill up all"
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
          "Search" : "Search",
          "Empty" : "No contacts",
          "nameHint" : "Enter name",
          "numberHint" : "Enter number"
        },
        "Weather" : {
          "WeatherTitle" : "Weather Update",
          "Button" : "Open live earth",
          "dropdownHint" : "Select a municipality",
          "ForecastLabel" : "This week's forecast"
        },
        "Forum" : {
          "PostButton" : "Share a thought",
          "Offline" : "Offline mode. Cannot Post and Like",
          "NoPost" : "No post available",
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
        },
        "Report": {
          "reportName" : "Report Name: ",
          "reportLabel" : "Send Report",
          "location" : "Location",
          "locationHint" : "Enter your location",
          "content" : "Content",
          "contentHint" : "Report context",
          "uploadLabel" : "Upload Photo",
          "uploadHint" : "Pick a Photo",
          "appBarTitle" : "Report To Authorities"
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
          "NoAnnouncement" : "Walang Anunsyo",
          "PostAnnounce" : "Maganunsyo",
          "NaturalDis" : "Natural na Sakuna",
          "ManmadeDis" : "Sakunang Gawang-tao",
          "SearchEvac" : "Maghanap ng Evacuation Center",
          "MarkEvac" : " Magmarka ng mga Evacuation Center", //responder version
          "News" : "Mga Balita",
          "Weather" : "Ang Panahon",
          "Kit" : "Aking Kits",
          "ReportLabel" : "Magpadala ng ulat",
          "ReportResp" : "Tingnan ang mga ulat", //reponder version
          "ReportRespButton" : "Mga ulat", //reponder version
          "Report" : "Magulat" 
        },
      "MakeAnnounce" : {
          "AnnounceTitle" : "Gumawa ng Anunsyo",
          "Today" : "Ngayon",
          "Title" : "Titulo",
          "TitleHint" : "Maglagay ng titulo",
          "Content" : "Laman",
          "ContentHint" : "Maglagay ng nilalaman",
          "Urgent" : "Importante",
          "NoContent" : "Walang laman, siguradohin na may laman ang mga text fields"
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
          "Search" : "Hanapin",
          "Empty" : "Walang laman",
          "nameHint" : "Maglagay ng pangalan",
          "numberHint" : "Maglagay ng numero"
        },
      "Weather" : {
          "WeatherTitle" : "Ulat ng Panahon",
          "Button" : "Buksan ang live earth",
          "ForecastLabel" : "Taya para sa linggong ito"
        },
      "Forum" : {
          "PostButton" : "Magbahagi ng saloobin",
          "Offline" : "Offline mode. Hindi maka-Post at Like",
          "NoPost" : "Walang mga post",
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
        },
      "Report": {
          "reportName" : "Pangalan ng Report: ",
          "reportLabel" : "Magpadala ng ulat",
          "location" : "Lokasyon",
          "locationHint" : "Ilagay ang iyong lokasyon",
          "content" : "Content",
          "contentHint" : "Ano ang konteksto",
          "uploadLabel" : "Mag-upload ng lalarawan",
          "uploadHint" : "Pumili ng larawan",
          "appBarTitle" : "Magulat sa Awtoridad"
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
          "NoAnnouncement" : "Uwa it Anunsyo",
          "PostAnnounce" : "Maganunsyo",
          "NaturalDis" : "Natural na Sakuna",
          "ManmadeDis" : "Sakunang Gawa-tao",
          "SearchEvac" : "Magusoy ng Evacuation Center",
          "MarkEvac" : " Magmarka it mga Evacuation Centers", //responder version
          "News" : "Mga Balita",
          "Weather" : "Ang Panahon",
          "Kit" : "Akong Kits",
          "ReportLabel" : "Magpadaea it report",
          "ReportResp" : "Mantawon ang mga ulat", //reponder version
          "ReportRespButton" : "Mga ulat", //reponder version
          "Report" : "Magreport" 
        },
        "MakeAnnounce" : {
          "AnnounceTitle" : "Maghimo it Anunsyo",
          "Today" : "Makara",
          "Title" : "Titulo",
          "TitleHint" : "Magbutang it titulo",
          "Content" : "Laman",
          "ContentHint" : "Magbutang it nilalaman",
          "Urgent" : "Importante",
          "NoContent" : "Uwa it sueod, siguradohon nga may sueod ang mga text fields"
        },
        "Contact" : {
          "Label" : "Akong Kontaks",
          "Search" : "Pangitaon",
          "Empty" : "Wa it seuod",
          "nameHint" : "Magbutang it pangalan",
          "numberHint" : "Magbutang it numero"
        },
        "Weather" : {
          "WeatherTitle" : "Ulat it Panahon",
          "Button" : "Buksan ang live earth",
          "ForecastLabel" : "Forcast it makarang dominggo"
        },
        "Forum" : {
          "PostButton" : "Magbahagi it saloobin",
          "Offline" : "Offline mode. Hindi maka-Post at Like",
          "NoPost" : "Uwa it mga post",
          "DialogTitle" : "Magbahagi it saloobin",
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
          "birthday" : "Kaadlawan",
          "edit": "Baguhon ang profile",
          "nonet": "Wa it Internet.",
          "changeemail" : "Bag-ohon ang email",
          "changepass" : "Bag-ohon ang password"
        },
        "Emergency" : {
          "host" : "Listahan it mga ostpital",
          "fire" : "Numero it Bombero",
          "coast" : "Numero it Coastguard"
        },
        "Report": {
          "reportName" : "Pangalan it Report: ",
          "reportLabel" : "Magpadaea it report",
          "location" : "Lokasyon",
          "locationHint" : "Ibutang ang imong lokasyon",
          "content" : "Content",
          "contentHint" : "Ano ang konteksto",
          "uploadLabel" : "Mag-upload it lalarawan",
          "uploadHint" : "Magpili it larawan",
          "appBarTitle" : "Magreport sa Awtoridad"
        }
    };
  }
}



