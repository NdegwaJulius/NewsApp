// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/views/category_news.dart';

import '../helper/news.dart';
import '../helper/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  //const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool _loading;
  var newslist;
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles =  <ArticleModel>[];


  @override
  void initState(){
    _loading = true;
    //TODO: IMPLEMENT INITSTATE
    super.initState();
     categories = getCategories();
     getNews();
     //as List<CategoryModel>;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _loading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /// Categories
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    }),
              ),

              /// News Article
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: newslist.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsTile(
                        imgUrl: newslist[index].urlToImage ?? "",
                        title: newslist[index].title ?? "",
                        desc: newslist[index].description ?? "",
                        content: newslist[index].content ?? "",
                        posturl: newslist[index].articleUrl ?? "",
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getNews() {}
}

class CategoryCard extends StatelessWidget {
  final String imageUrl, categoryName;

  // ignore: use_key_in_widget_constructors
  const CategoryCard({required this.imageUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              newsCategory: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}