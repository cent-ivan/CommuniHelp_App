import 'package:flutter/material.dart';


class NaturalDisasterViewModel extends ChangeNotifier{
  String? pageTitle;
  String? disasterPath;
  String? userLanguage;

  final Map<String, List<String>> assetEnglishPaths = {
    "Typhoon" : [
      //English typhoon
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon1.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon2.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon3.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon4.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon5.png',
    ],
    "Flood" : [
      //English flood
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood1.png',
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood2.png',
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood3.png',
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood4.png',
      'assets/images/infographics/natural_infographics/flood/flood_En/Flood5.png',
    ],
    "Landslide" : [
      //English landslide
      'assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide1.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide2.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide3.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide4.png',
    ],
    "Earthquake" : [
      //English Earthquake
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake1.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake2.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake3.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake4.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake5.png',
    ]
  };

  final  Map<String, List<String>> assetFilipinoPaths = {
    "Typhoon" : [
      //Filipino typhoon
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo1.png', 
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo2.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo3.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo4.png',
      'assets/images/infographics/natural_infographics/typhoon/typhoon_Fil/Bagyo5.png',
    ],
    "Flood" : [
      //Filipino flood
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha1.png',
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha2.png',
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha3.png',
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha4.png',
      'assets/images/infographics/natural_infographics/flood/flood_Fil/Baha5.png',
    ],
    "Landslide" : [
      //Filipino landslide
      'assets/images/infographics/natural_infographics/landslide/landslide_Fil/Pagguho1.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_Fil/Pagguho2.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_Fil/Pagguho3.png',
      'assets/images/infographics/natural_infographics/landslide/landslide_Fil/Pagguho4.png',
    ],
    "Earthquake" : [
      //Filipino Earthquake
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol1.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol2.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol3.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol4.png',
      'assets/images/infographics/natural_infographics/earthquake/earthquake_Fil/Lindol5.png',
    ]
  };

  void getPath(String disaster, String language) {
    userLanguage = language;
    if (language.contains("En")) {
      for (String key in assetEnglishPaths.keys) {
        if (disaster == key) {
          disasterPath = key;
          notifyListeners();
        }
      }
    }
    else if (language.contains("Fil")) {
      for (String key in assetFilipinoPaths.keys) {
        if (disaster == key) {
          disasterPath = key;
          notifyListeners();
        }
      }
    }
  }
  
}