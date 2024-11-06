import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NewsViewModel extends ChangeNotifier{
  Logger logger = Logger();

  final apiKey = '83325436e3d949bd8da939c060580c9f';
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
      url = 'https://newsapi.org/v2/everything?q=(disaster%20AND%20Typhoon%20AND%20philippines%20AND%20natural%20disaster)&sortBy=popularity&apiKey=$apiKey';
    } else if (category == "International News") {
      url = 'https://newsapi.org/v2/everything?q=(Disaster%20AND%20safety%20AND%20world%20AND%20natural%20disaster)&sortBy=popularity&apiKey=$apiKey';

    } else if (category == "Weather News") {
      url = 'https://newsapi.org/v2/everything?q=Philippines%20weather&apiKey=$apiKey';

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
          url = 'https://newsapi.org/v2/everything?q=Philippines&apiKey=$apiKey';
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