import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class HiveDbWeather extends ChangeNotifier{
  Logger logger = Logger(); //diplay debug messages


  Map<dynamic, dynamic> weatherData = {};

  //initiate hive box
  final _weather = Hive.box<Map<dynamic, dynamic>>('weatherbox');

  void loadData() {
    weatherData = _weather.get('WEATHER')!;
    logger.i("Weather got");
  }

  void updateData() {
    
    _weather.put('WEATHER', weatherData);
    logger.i("Weather DB: Updated");
  }
}