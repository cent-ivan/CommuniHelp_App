import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsModel {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  DirectionsModel({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration
  });

  factory DirectionsModel.fromMap(Map<String, dynamic> map) {
    //get route info
    final data = Map<String, dynamic>.from(map['routes'][0]);

    //get bounds
    final northeast = data["bounds"]["northeast"];
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

    return DirectionsModel(
      bounds: bounds, 
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']), 
      totalDistance: distance, 
      totalDuration: duration
    );
  }
}