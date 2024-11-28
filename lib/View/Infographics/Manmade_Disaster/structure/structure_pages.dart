import 'package:communihelp_app/ViewModel/Inforgraphics_Controller/manmade_dis_view_model.dart';
import 'package:flutter/material.dart';


class StructurePages extends ChangeNotifier {
  List<String> getList(String language, ManMadeDisasterViewModel viewModel) {
    List<String>? disasterList;
    switch (language) {
      case "EN":
        disasterList = viewModel.assetEnglishPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "FIL":
        disasterList = viewModel.assetFilipinoPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "AKL":
        disasterList = viewModel.assetAklanonPaths[viewModel.disasterPath]?.sublist(1);
        break;
      default:
    }
    return disasterList!;
  }
}