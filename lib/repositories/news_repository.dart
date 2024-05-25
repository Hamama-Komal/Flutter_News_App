import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_channel.dart';

import '../models/news_category.dart';

class NewsRepo {
  Future<NewsChannel> fetchNewsChannelHeadlinesApi(String channelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=9eb41bb9022241f1b381de33dfe0b43b";
    final response = await http.get(Uri.parse(url));

    // testing API
    if (kDebugMode) {
     // print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannel.fromJson(body);
    }
    throw Exception('Error');
  }

// Repository of News Category
  Future<CategoryModel> fetchNewsCategoryApi(String categoryName) async {
    String url =
        "https://newsapi.org/v2/everything?q=${categoryName}y&apiKey=9eb41bb9022241f1b381de33dfe0b43b";
    final response = await http.get(Uri.parse(url));

    // testing API
    if (kDebugMode) {
     // print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoryModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
