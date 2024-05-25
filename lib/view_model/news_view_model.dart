import 'package:news_app/models/news_category.dart';
import 'package:news_app/repositories/news_repository.dart';

import '../models/news_channel.dart';

class NewsViewModel{

  final _rep = NewsRepo();


  Future<NewsChannel> fetchNewsChannelHeadlinesApi(String channelName) async{

    final response = _rep.fetchNewsChannelHeadlinesApi(channelName);
    return response;
  }


  Future<CategoryModel> fetchNewsCategoryApi(String category) async{
    final response = _rep.fetchNewsCategoryApi(category);
    return response;
  }



}