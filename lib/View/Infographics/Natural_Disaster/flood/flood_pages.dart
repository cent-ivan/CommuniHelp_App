import 'package:flutter/material.dart';

import '../../../../ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';

class FloodPages extends ChangeNotifier {
  List<String> getList(String language, NaturalDisasterViewModel viewModel) {
    List<String>? floodList;
    switch (language) {
      case "EN":
        floodList = viewModel.assetEnglishPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "FIL":
        floodList = viewModel.assetFilipinoPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "AKL":
        floodList = viewModel.assetAklanonPaths[viewModel.disasterPath]?.sublist(1);
        break;
      default:
    }
    return floodList!;
  }
}