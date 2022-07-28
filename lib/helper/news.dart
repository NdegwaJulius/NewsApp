import '../models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../views/article_view.dart';

class News{
  List<ArticleModel>  news = [];
  Future<void> getNews() async {
    String  url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=bd0b1d97ed7847fb9eaf2f08be442066";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] =="ok" ){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            //publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"], url: '',
          );
          news.add(articleModel);
        }


      });
    }
  }


}

