import 'package:communihelp_app/Model/directions_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

class DirectionRepo {
  Logger logger = Logger();//for debug messages

  final _baseUrl = dotenv.env['DIRECTIONS_BASE_URL'];
  final _apiKey = dotenv.env['GOOGLE_MAP_KEY'];

  final  _dio = Dio();

  DirectionRepo({Dio? dio});

  Future<DirectionsModel?> getDirection(LatLng origin, LatLng destination) async {
    DirectionsModel? dataMap;
    try {
      Response response = await _dio.get(
        _baseUrl!,
        queryParameters: {
          'origin' : "${origin.latitude},${origin.longitude}",
          'destination' : "${destination.latitude}, ${destination.longitude}",
          'key':_apiKey
        }
      );
      if (response.statusCode == 200) {
        dataMap = DirectionsModel.fromMap(response.data);
      }
    } catch(e) {
      logger.i("Error: ${e.toString()}");
    }
    logger.i(dataMap);
    return dataMap;
  }
  
}