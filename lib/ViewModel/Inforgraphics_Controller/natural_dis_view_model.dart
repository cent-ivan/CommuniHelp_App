import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class NaturalDisasterViewModel extends ChangeNotifier{
  Logger logger = Logger();
  
  String? coverPath;
  String? disasterDialog;
  String? disasterPath;
  String? userLanguage;

  final Map<String, List<String>> assetEnglishPaths = {
    "TYPHOON" : [
      //English typhoon
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon1_cover_En.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon1.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon2.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon3.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon4.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon5.png',
    ],
    "FLOOD" : [
      //English flood
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood1_cover_En.png',
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood1.png',
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood2.png',
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood3.png',
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood4.png',
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood5.png',
    ],
    "LANDSLIDE" : [
      //English landslide
      'assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide1_cover_En.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide1.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide2.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide3.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide4.png',
    ],
    "EARTHQUAKE" : [
      //English Earthquake
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake1_cover_En.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake1.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake2.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake3.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake4.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake5.png',
    ]
  };

  final  Map<String, List<String>> assetFilipinoPaths = {
    "TYPHOON" : [
      //Filipino typhoon
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo1_cover_Fil.png', 
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo1.png', 
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo2.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo3.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo4.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo5.png',
    ],
    "FLOOD" : [
      //Filipino flood
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha1_cover_Fil.png',
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha1.png',
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha2.png',
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha3.png',
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha4.png',
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha5.png',
    ],
    "LANDSLIDE" : [
      //Filipino landslide
      'assets/images/infographics/natural_infographics/landslide/landslide_Fil/Pagguho1_cover_Fil.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_Fil/Pagguho1.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_Fil/Pagguho2.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_Fil/Pagguho3.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_Fil/Pagguho4.png',
    ],
    "EARTHQUAKE" : [
      //Filipino Earthquake
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol1_cover_Fil.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol1.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol2.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol3.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol4.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol5.png',
    ]
  };

  void getPath(String disaster, String language) {
    userLanguage = language;
    if (language.toLowerCase() == "en" ) {
      for (String key in assetEnglishPaths.keys) {
        if (disaster.toUpperCase() == key) {
          coverPath = assetEnglishPaths[key]?[0]; //gets the cover path in the path list
          disasterPath = key;
          _getDisasterDialog(disasterPath!); //gets the dialog in user setting
          notifyListeners();
        }
      }
    }
    else if (language.toLowerCase() == "fil" || language.toLowerCase() =="akl" ) {
      for (String key in assetFilipinoPaths.keys) {
        if (disaster.toUpperCase() == key) {
          coverPath = assetFilipinoPaths[key]?[0];
          disasterPath = key;
          _getDisasterDialog(disasterPath!); //gets the dialog in user setting
          notifyListeners();
        }
      }
    }
  }

  void _getDisasterDialog(String disaster) {
    if (disaster == "TYPHOON") {
      disasterDialog = "TyDialog";
      notifyListeners();
    }
    else if (disaster == "FLOOD") {
      disasterDialog = "FloodDialog";
      notifyListeners();
    }
    else if (disaster == "LANDSLIDE") {
      disasterDialog = "LandDialog";
      notifyListeners();
    }
    else if (disaster == "EARTHQUAKE") {
      disasterDialog = "EarthDialog";
      notifyListeners();
    }
    else {
      disasterDialog = "None";
    }
  }

  
}