import 'package:flutter/material.dart';

class NaturalDisasterViewModel extends ChangeNotifier{
  String? pageTitle;
  String? disasterPath;

  final Map<String, List<String>> assetPaths = {
    "Typhoon" : [
      "assets/images/infographics/natural_infographics/typhoon_1.png",
      "assets/images/infographics/natural_infographics/typhoon_2.png"
    ],
    "Flood" : [
      "assets/images/infographics/natural_infographics/typhoon_1.png",
      "assets/images/infographics/natural_infographics/typhoon_2.png"
    ],
  };

  void getPath(String disaster) {
    for (String key in assetPaths.keys) {
      if (disaster == key) {
        disasterPath = key;
        notifyListeners();
      }
    }

  }
  
}