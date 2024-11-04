import 'package:flutter/material.dart';


class NaturalDisasterViewModel extends ChangeNotifier{
  String? pageTitle;
  String? disasterPath;
  String? userLanguage;

  final Map<String, List<String>> assetEnglishPaths = {
    "Typhoon" : [
      //English typhoon
      "assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon1.png",
      "assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon2.png",
      "assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon3.png",
      "assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon4.png",
      "assets/images/infographics/natural_infographics/typhoon/typhoon_En/Typhoon5.png",
    ],
    "Flood" : [
      //English flood
      "assets/images/infographics/natural_infographics/flood/flood_En/Flood1.png",
      "assets/images/infographics/natural_infographics/flood/flood_En/Flood2.png",
      "assets/images/infographics/natural_infographics/flood/flood_En/Flood3.png",
      "assets/images/infographics/natural_infographics/flood/flood_En/Flood4.png",
      "assets/images/infographics/natural_infographics/flood/flood_En/Flood5.png",
    ],
    "Landslide" : [
      //English landslide
      "assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide1.png",
      "assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide2.png",
      "assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide3.png",
      "assets/images/infographics/natural_infographics/landslide/landslide_En/Landslide4.png",
    ],
    "Earthquake" : [
      //English Earthquake
      "assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake1.png",
      "assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake2.png",
      "assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake3.png",
      "assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake4.png",
      "assets/images/infographics/natural_infographics/earthquake/earthquake_En/Earthquake5.png",
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
  }
  
}