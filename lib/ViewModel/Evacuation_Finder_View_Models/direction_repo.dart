import 'package:communihelp_app/Model/directions_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:logger/logger.dart';

class DirectionRepo extends ChangeNotifier{
  Logger logger = Logger();//for debug messages

  final _baseUrl = dotenv.env['DIRECTIONS_BASE_URL'];
  final _apiKey = dotenv.env['GOOGLE_MAP_KEY'];

  final  _dio = Dio();
  List<String> textDirection = [];

  DirectionRepo({Dio? dio});

  Future<DirectionsModel?> getDirection(LatLng origin, LatLng destination, String mode) async {
    DirectionsModel? dataMap;
    try {
      //Dio handles http request by coverting it to json
      Response response = await _dio.get(
        _baseUrl!, //url path of the Diections API of Google API
        queryParameters: {
          'origin' : "${origin.latitude},${origin.longitude}", //the user's or marker's latitude and longitude 
          'destination' : "${destination.latitude}, ${destination.longitude}", //the evacuaton or marker's latitude and longitude 
          'mode' : mode,
          'alternatives': true, 
          'key':_apiKey //the api key
        }
      );
      if (response.statusCode == 200) {
        _extractDirectionsFromResponse(response.data);
        dataMap = DirectionsModel.fromMap(response.data); //if successful convert response to Model via ORM

      }
    } catch(e) {
      logger.i("Error: ${e.toString()}"); //catches if error
    }


    logger.i(dataMap);
    return dataMap;
  }


  Map<String, dynamic> _findShortestRoute(Map<String, dynamic> data) {
    List<dynamic> routes = data['routes'];
    Map<String, dynamic> shortestRoute = routes.first;
    double shortestDistance = double.infinity;

    for (var route in routes) {
      double totalDistance = 0.0;

      // Calculate total distance for the route
      for (var leg in route['legs']) {
        totalDistance += leg['distance']['value']; // Distance in meters
      }

      // Update the shortest route if this route is shorter
      if (totalDistance < shortestDistance) {
        shortestDistance = totalDistance;
        shortestRoute = route;
      }
    }

    return shortestRoute;
  }

  //get text direction instruction
  void _extractDirectionsFromResponse(Map<String, dynamic> data) {
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
    
    textDirection = directions;
  }
  
}

// import 'package:communihelp_app/Model/directions_model.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:logger/logger.dart';

// class DirectionRepo {
//   Logger logger = Logger();//for debug messages

//   final _baseUrl = dotenv.env['DIRECTIONS_BASE_URL'];
//   final _apiKey = dotenv.env['GOOGLE_MAP_KEY'];

//   final  _dio = Dio();

//   DirectionRepo({Dio? dio});

//   Future<DirectionsModel?> getDirection(LatLng origin, LatLng destination, String mode) async {
//     DirectionsModel? dataMap;
//     try {
//       //Dio handles http request by coverting it to json
//       Response response = await _dio.get(
//         _baseUrl!, //url path of the Diections API of Google API
//         queryParameters: {
//           'origin' : "${origin.latitude},${origin.longitude}", //the user's or marker's latitude and longitude 
//           'destination' : "${destination.latitude}, ${destination.longitude}", //the evacuaton or marker's latitude and longitude 
//           'mode' : mode,
//           'alternatives': true, 
//           'key':_apiKey //the api key
//         }
//       );
//       if (response.statusCode == 200) {
//         dataMap = DirectionsModel.fromMap(response.data); //if successful convert response to Model via ORM
//       }
//     } catch(e) {
//       logger.i("Error: ${e.toString()}"); //catches if error
//     }


//     logger.i(dataMap);
//     return dataMap;
//   }


  
  
// }