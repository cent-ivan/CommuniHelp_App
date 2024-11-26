import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';

class DirectionsModel {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;
  final List<String> textDirections;

  DirectionsModel({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
    required this.textDirections
  });

  factory DirectionsModel.fromMap(Map<String, dynamic> map) {
    //get route info from json
    final data = Map<String, dynamic>.from(map['routes'][0]);

    //get route bounds
    final northeast = data["bounds"]["northeast"]; //area that the map is zoomed in on
    final southwest = data["bounds"]["southwest"];
    final bounds = LatLngBounds(
      southwest: LatLng(southwest['lat'], southwest['lng']), 
      northeast: LatLng(northeast['lat'], northeast['lng'])
    );

    //get totalDuration
    String distance = ''; //already calculated by api
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0]; //gets result of legs
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }


    
    
    //returns object
    return DirectionsModel(
      bounds: bounds, 
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance, 
      totalDuration: duration,
      textDirections: _extractDirectionsFromResponse(map)
    );
  }


  //get text direction instruction
  static List<String> _extractDirectionsFromResponse(Map<String, dynamic> data) {
    List<String> directions = [];

    for (var leg in data['routes'][0]['legs']) {
      
      for (var step in leg['steps']) {
        // Parse and clean the HTML instructions
        String htmlInstructions = step['html_instructions'];
        String cleanText = parse(htmlInstructions).body?.text ?? ""; // Strips HTML tags
        String? maneuver = step['maneuver']; // Get maneuver field
      
        // Assign icon based on maneuver
        String icon = "";
        if (maneuver != null) {
          if (maneuver.contains("left")) {
            icon = "⬅️"; 
          } else if (maneuver.contains("right")) {
            icon = "➡️"; 
          } else if (maneuver == "straight") {
            icon = "⬆️"; 
          } else if (maneuver.contains("roundabout")) {
            icon = "🔄"; 
          } else if (maneuver == "walk-on-street") {
            icon = "🚶"; 
          } else if (maneuver == "bike-lane" || maneuver.contains("bike")) {
            icon = "🚴"; 
          }
        }

        // Combine icon with instructions
        String instructions = "$icon $cleanText";
        directions.add(instructions);
      }
    }
    
    return directions;
  }
}