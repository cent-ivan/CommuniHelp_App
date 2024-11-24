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
          'key':_apiKey //the api key
        }
      );
      if (response.statusCode == 200) {
        dataMap = DirectionsModel.fromMap(response.data); //if successful convert response to Model via ORM
      }
    } catch(e) {
      logger.i("Error: ${e.toString()}"); //catches if error
    }


    logger.i(dataMap);
    return dataMap;
  }
  
}