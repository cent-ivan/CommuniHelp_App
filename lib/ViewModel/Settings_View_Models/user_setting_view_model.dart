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
          "TyDialog" : "This infographic will show you how to get ready for a typhoon so you can stay safe. It also explains what to do while the typhoon is happening and what steps to take after it passes to keep you and your family safe.",
          "FloodButton" : "Flood",
          "FloodDialog" : "This infographic will guide you on how to prepare for a flood to keep you and your family safe. It also explains what to do during the flood to stay out of danger and what steps to take after the flood to stay safe and what to do after.",
          "LandButton" : "Landslide",
          "LandDialog" : "This infographic will help you learn how to prepare for a landslide to keep yourself and your family safe. It also explains what to do during a landslide to avoid danger and what steps to take after it to stay safe and recover.",
          "EarthButton" : "Earthquake",
          "EarthDialog" : "This infographic will guide you on how to prepare for an earthquake to keep yourself and your family safe. It also explains what to do during the earthquake to stay protected and what steps to take after it to stay safe and recover.",
          "StartButton" : "Read",
          "Next" : "Next",
          "Finish": "Finish"
        },
        "ManmadeInfo" : {
        "Title" : "Man-made Disaster",
        "Definition" : "A man-made disaster can strike with devastating consequences, often stemming from human error, negligence, or intentional harm.",
        "Types" : "Kinds of Man-made disasters",
        "Accident" : "Vehicular Incident",
        "AccidentDialog" : "This infographic will help you learn how to prepare for a vehicular accident and how to stay safe in case it happens. It will also guide you on what to do during the accident to protect yourself and others. Additionally, it will explain the important steps to take after the accident to stay safe, seek help, and recover properly.",
        "Fire" : "Fire related disaster",
        "FireDialog" : "This infographic will help you learn how to prepare for a fire, so you can stay safe before it happens. It will also guide you on what to do during a fire to protect yourself and others. Additionally, it will show you the important steps to take after the fire to ensure your safety and help you recover.",
        "Failure" : "Structural Failures",
        "FailureDialog" : "This infographic will guide you on how to prepare for structural failure, such as the collapse of buildings. It will explain the warning signs you should watch out for to stay safe before a failure happens. During a structural failure, it will show you what to do to protect yourself and others. After the failure, it will provide important steps to take for your safety, as well as how to assist in recovery and avoid further damage.",
        "Pollution" : "Water Pollution",
        "PollutionDialog" : "This infographic will help you understand how water pollution happens and what you can do to help prevent it. It will also show you the effects of water pollution on the environment and health. Additionally, it will guide you on the steps you can take to protect water sources and reduce pollution for a cleaner, safer environment.",
        "StartButton" : "Read",
        "Next" : "Next",
        "Finish": "Finish"
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
        },
      "Share" : {
        "description" : "Scan the qr code and press the file or APK in the website. Give permission to download the app and wait until the download process is complete"
      },
      "PhonePerm" : {
        "title" : "Phone Permission Needed",
        "description" :  "We need phone permission to allow this feature to work properly. Please grant it to continue."
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
        "TyDialog" : "Ang infographic na ito ay magpapakita sa iyo kung paano maghanda para sa bagyo upang manatiling ligtas. Ipinapaliwanag din dito kung ano ang dapat gawin habang may bagyo at kung anong mga hakbang ang dapat gawin pagkatapos nitong dumaan upang mapanatiling ligtas ang iyong sarili at pamilya.",
          "FloodButton" : "Baha",
          "FloodDialog" : "Ang dayang infographic ay magpakita kimo kung paano magprepaeae agud mangin ligtas sa baha. Ginapaliwanag man daya kung ano ang mga ueubeahon habang nasa baha at kung ano ang mga hakbang na dapat ubeahon pagkatapos it baha para maluwas ro imong sarili at pamilya.",
          "LandButton" : "Pagguho it eugta",
          "LandDialog" : "Ang infographic na ito ay tutulong sa iyo na matutunan kung paano maghanda para sa pagguho ng lupa upang mapanatiling ligtas ang iyong sarili at pamilya. Ipinaliwanag din nito kung ano ang dapat gawin habang may pagguho ng lupa upang maiwasan ang panganib at kung anong mga hakbang ang dapat gawin pagkatapos nito upang manatiling ligtas at maka-recover.",
          "EarthButton" : "Linog",
          "EarthDialog" : "Ang infographic na ito ay gagabay sa iyo kung paano maghanda para sa lindol upang mapanatiling ligtas ang iyong sarili at pamilya. Ipinaliwanag din nito kung ano ang dapat gawin habang may lindol upang maiwasan ang panganib at kung anong mga hakbang ang dapat gawin pagkatapos ng lindol upang manatiling ligtas at kung ano pa ang dapat gawin.",
        "StartButton" : "Basahin",
        "Next" : "Sunod",
        "Finish": "Tapos"
      },
      "ManmadeInfo" : {
        "Title" : "Mga sakunang likha ng tao",
        "Definition" : "Ang isang sakunang likha ng tao ay maaaring magdulot ng matinding pinsala, na kadalasang nagmumula sa pagkakamali, kapabayaan, o sinadyang pananakit ng tao.",
        "Types" : "Uri ng sakunang likha ng tao",
        "Accident" : "Aksidente sa sasakyan",
        "AccidentDialog" : "Ang infographic na ito ay tutulong sa iyo na matutunan kung paano maghanda para sa aksidente sa sasakyan at kung paano manatiling ligtas sakaling mangyari ito. Gabay din ito sa mga hakbang na dapat gawin habang nangyayari ang aksidente upang maprotektahan ang iyong sarili at ang iba. Karagdagan pa, ipapaliwanag nito ang mga mahahalagang hakbang na dapat gawin pagkatapos ng aksidente upang manatiling ligtas.",
        "Fire" : "Sunog",
        "FireDialog" : "Ang infographic na ito ay tutulong sa iyo na matutunan kung paano maghanda para sa sunog, upang manatiling ligtas bago ito mangyari. Gabay din ito sa mga hakbang na dapat gawin habang may sunog upang maprotektahan ang iyong sarili at ang iba. Karagdagan pa, ipapakita nito ang mga mahahalagang hakbang na dapat gawin pagkatapos ng sunog upang tiyakin ang iyong kaligtasan.", 
        "Failure" : "Pagbagsak ng estruktura",
        "FailureDialog" : "Ang infographic na ito ay magbibigay gabay kung paano maghanda para sa pagkasira ng mga istruktura, tulad ng pagbagsak ng mga gusali. Gabay ito sa mga no dapat gawin bago, habang at pagkatapos mangyari ang pagkasira.",
        "Pollution" : "Polusyon sa tubig",
        "PollutionDialog" : "Ang infographic na ito ay tutulong sa iyo na maunawaan kung paano nangyayari ang polusyon sa tubig at kung ano ang maaari mong gawin upang makatulong na maiwasan ito. Ipapakita rin nito ang mga epekto ng polusyon sa tubig sa kalikasan at kalusugan. Karagdagan pa, gagabayan ka nito sa mga hakbang na maaari mong gawin upang protektahan ang mga pinagkukunan ng tubig at mabawasan ang polusyon para sa mas malinis at mas ligtas na kapaligiran.",
        "StartButton" : "Basahin",
        "Next" : "Sunod",
        "Finish": "Tapos"
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
        },
      "Share" : {
        "description" : "I-scan ang qr code at pindutin ang file o APK sa website. Bigyan ng permisyon na downloadin ang app at hintayin ito matapos."
      },
      "PhonePerm" : {
        "title" : "Kailangan ng Pahintulot",
        "description" :  "Kailangan namin ng pahintulot sa telepono upang gumana nang maayos ang feature na ito. Pasugtan raya para makatuloy."
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
          "ManmadeDis" : "Sakuna Ubra it tawo",
          "SearchEvac" : "Magpangita ng Evacuation Center",
          "MarkEvac" : " Magmarka it mga Evacuation Centers", //responder version
          "News" : "Mga Balita",
          "Weather" : "Ang Panahon",
          "Kit" : "Akong Kits",
          "ReportLabel" : "Magpadaea it report",
          "ReportResp" : "Mantawon ang mga ulat", //reponder version
          "ReportRespButton" : "Mga ulat", //reponder version
          "Report" : "Magreport" 
        },
        "NaturalInfo" : {
          "NaturalTitle" : "Natural nga kalamidad",
          "Definition" : "Ang mga natural , such as typhoons, earthquakes, floods, landslide, and many more, can cause widespread devastation and loss of life. These events are often unpredictable and can occur suddenly, leaving communities with little time to prepare.",
          "Types" : "Types of Natural Disasters",
          "TyButton" : "Bagyo",
          "TyDialog" : "Ang dayang infographic ay magpakita kimo kung paano magprepaeae agud mangin ligtas sa bagyo. Ginapaliwanag man daya kung ano ang mga ueubeahon habang may bagyo at kung ano ang mga hakbang na dapat ubeahon pagkatapos it bagyo para maluwas ro imong sarili at pamilya.",
        "FloodButton" : "Baha",
        "FloodDialog" : "Ang dayang infographic ay magpakita kimo kung paano magprepaeae agud mangin ligtas sa baha. Ginapaliwanag man daya kung ano ang mga ueubeahon habang nasa baha at kung ano ang mga hakbang na dapat ubeahon pagkatapos it baha para maluwas ro imong sarili at pamilya.",
        "LandButton" : "Pagguho ng lupa",
        "LandDialog" : "Ang dayang infographic ay makabulig kimo para matun-an kung paano maghanda pagguho it eugta. Ginapaliwanag man daya kung ano ang mga ueubeahon habang may pagguho it eugta at kung ano ang mga hakbang na dapat ubeahon pagkatapos it sakuna para maluwas ro imong sarili at imong pamilya.",
        "EarthButton" : "Lindol",
        "EarthDialog" : "Ang dayang infographic ay magpakita kimo kung paano magprepaeae agud mangin ligtas sa linog. Ginapaliwanag man daya kung ano ang mga ueubeahon habang nagalinog at kung ano ang mga hakbang na dapat ubeahon pagkatapos it linog para maluwas ro imong sarili at pamilya.",
          "StartButton" : "Basahon",
          "Next" : "Sunod",
          "Finish": "Tapos"
        },
        "ManmadeInfo" : {
        "Title" : "Mga sakuna nga ubra it tawo",
        "Definition" : "Ang isang sakunang likha ng tao ay maaaring magdulot ng matinding pinsala, na kadalasang nagmumula sa pagkakamali, kapabayaan, o sinadyang pananakit ng tao.",
        "Types" : "Uri it sakunang nga ubra it tawo",
        "Accident" : "Aksidente sa saeakyan",
        "AccidentDialog" : "Ang dayang infographic ay makabulig kimo para matun-an kung paano maghanda ro sarili sa aksidente sa saeakyan o sa kalsada. Ginapaliwanag man daya kung ano ang mga ueubeahon habang gatabo ang aksidente at kung ano ang mga ubeahon pagkatapos it aksidente para maluwas ro imong sarili at imong pamilya.",
        "Fire" : "Sunog",
        "FireDialog" : "Ang dayang infographic ay makabulig kimo para matun-an kung paano maghanda ro sarili sa sunog. Ginapaliwanag man daya kung ano ang mga ueubeahon habang gatabo ang sunog at kung ano ang mga ubeahon pagkatapos it sunog.", 
        "Failure" : "Pagbagsak ng estruktura",
        "FailureDialog" : "Ang dayang infographic ay makatao kimo it gabay kung paano magprepaeae sa pakasamad it istruktura, pareho it pagkahueog it isa ka gusali. Ginapaliwanag man daya kung ano ang mga ueubeahon habang gatabo at kung ano ang mga ubeahon pagkatapos it sakuna.",
        "Pollution" : "Polusyon sa tubig",
        "PollutionDialog" : "Ang dayang infographic ay makatao kimo it bulig para matun-an kung paano nagatabo ang polusyon sa tubi. Ginapaliwanag man daya kung ano ang mga ueubeahon kung paano maiwasan at kung paano maprotektahan ang mga anyong tubig.",
        "StartButton" : "Basahon",
        "Next" : "Sunod",
        "Finish": "Tapos"
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
          "uploadLabel" : "Mag-upload it larawan",
          "uploadHint" : "Magpili it larawan",
          "appBarTitle" : "Magreport sa Awtoridad"
        },
      "Share" : {
        "description" : "I-scan ang qr code at pinduton ang file o APK sa website. Itao ang permisyon na downloadin ang app at hueaton matapos ang download process."
      },
      "PhonePerm" : {
        "title" : "Kailangan it Permiso",
        "description" :  "Kailangan namon it permiso sa telepono para gumana it mayad ang rayang feature. ."
      }
    };
  }
}



