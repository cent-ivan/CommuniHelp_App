import 'package:communihelp_app/Model/directions_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

class EvacuationFinderViewModel extends ChangeNotifier{
  Logger logger = Logger();

  Marker? origin;
  Marker? destination;
  DirectionsModel? direct;

  void clearMyPins() {
    origin = null;
    destination =  null;
    direct = null;
    notifyListeners();
  }
  
}