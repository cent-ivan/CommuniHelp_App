import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsViewModel extends ChangeNotifier{
  Logger logger = Logger();

  String url = "";

  final apiKey = dotenv.env['NEWS_API_KEY'];
  final localUrl = dotenv.env['LOCAL_NEWS_URL'];
  final interUrl = dotenv.env['INTER_NEWS_URL'];
  final weatherUrl = dotenv.env['WEATHER_NEWS_URL'];
  final nullUrl = dotenv.env['NULL_NEWS_URL'];

  void assignUrl(String passedUrl) {
    url = passedUrl;
    notifyListeners();
  }

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
      url = localUrl! + apiKey!;
    } else if (category == "International News") {
      url = interUrl! + apiKey!;

    } else if (category == "Weather News") {
      url = weatherUrl! + apiKey!;

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
        if (category == "Local News" && (data['articles'] == null || data['articles'].isEmpty)) {
          url = nullUrl! + apiKey!;
          final fallbackResponse = await http.get(Uri.parse(url));
          if (fallbackResponse.statusCode == 200) {
            final fallbackData = json.decode(fallbackResponse.body);
            return fallbackData['articles'] ?? [];
          }
        }
        return data['articles'] ?? [];
      } else {
        throw Exception("Failed to load news ${response.statusCode}");
      }
    } catch (error) {
      logger.e("Error fetching $category news: $error");
      return [];
    }
  }
}