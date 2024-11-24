import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsViewModel extends ChangeNotifier{
  Logger logger = Logger();

  String url = "";

  final apiKey = dotenv.env['NEWS_API_KEY'];
  final baseUrl = dotenv.env['NEWS_BASE_URL'];
  final localUrl = dotenv.env['LOCAL_NEWS_PARAM'];
  final interUrl = dotenv.env['INTER_NEWS_PARAM'];
  final weatherUrl = dotenv.env['WEATHER_NEWS_PARAM'];

  
  bool isLoading = true;
  List<dynamic> localArticles = [];
  List<dynamic> interArticles = [];
  List<dynamic> weatherArticles = [];

  Future callInit() async  {
    await localFetchAndDisplayNews("Local News");
    await interFetchAndDisplayNews("International News");
    await weatherFetchAndDisplayNews("Weather News");
    isLoading = false;
    notifyListeners();
  }


  Future<void> localFetchAndDisplayNews(String category) async {

    localArticles = await fetchNews(category);
    isLoading = false;
    notifyListeners();
  }

  Future<void> interFetchAndDisplayNews(String category) async {
    interArticles = await fetchNews(category);
    isLoading = false;
    notifyListeners();
    
  }

  Future<void> weatherFetchAndDisplayNews(String category) async {

    weatherArticles = await fetchNews(category);
    isLoading = false;
    notifyListeners();
  }

  //gets the news in the Url
  Future<List<dynamic>> fetchNews(String category) async {
    
    String url;
    if (category == "Local News") {
      url = baseUrl! + apiKey! + localUrl!;
    } else if (category == "International News") {
      url = baseUrl! + apiKey! + interUrl!;

    } else if (category == "Weather News") {
      url = baseUrl! + apiKey! + weatherUrl!;

    } else {
      throw Exception("Invalid category");
    }

    try {
      logger.i("fetched new");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        isLoading = false;
        notifyListeners();
        
        return data['results'] ?? [];
      } else {
        throw Exception("Failed to load news ${response.statusCode}");
      }
    } catch (error) {
      logger.e("Error fetching $category news: $error");
      return [];
    }
  }
}