import 'package:google_maps_flutter/google_maps_flutter.dart';

class EvacuationMarkerModel {
  String? name;
  LatLng? position;

  EvacuationMarkerModel({
    required this.name,
    required this.position
  });

  factory EvacuationMarkerModel.fromJson(Map<String, dynamic> json) {
    final position = LatLng(json["lat"], json["lng"]);
    return  EvacuationMarkerModel(
      name: json["name"], 
      position: position
    );

  }
}