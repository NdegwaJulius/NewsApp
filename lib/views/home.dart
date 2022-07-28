import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';

import '../helper/news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles =  <ArticleModel>[];

  bool _loading = true;
  @override
  void initState(){
    //TODO: IMPLEMENT INITSTATE
    super.initState();
     categories = getCategories();
     getNews();
     //as List<CategoryModel>;


  }
  getNews() async {
    News newsClass = News();
    await  newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("Flutter",style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text("News",
              style: TextStyle( color: Colors.blue)
              ,)
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:_loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) :Container(
        child: Column(
           children: <Widget>[

             ///Categories
             Container(
               padding: EdgeInsets.symmetric(horizontal: 16 ),
               height: 70,
               child: ListView.builder(
                   itemCount: categories.length,
                   shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context,index){
                     return CategoryTile(
                       imageUrl:categories[index].imageUrl,
                       categoryName: categories[index].categoryName,
                     );
                   }),
             ),
              ///blogs
             Container(
               child: ListView.builder(
                   itemCount: articles.length,
                   shrinkWrap: true,
                   itemBuilder: (context,index){
                     return BlogTile(
                         imageUrl: articles[index].urlToImage,
                         title: articles[index].title,
                         desc: articles[index].description,);
                   }),
             )
            ] ,
          ),
      ),
      );
     }
}
class CategoryTile extends StatelessWidget {
  final imageUrl,categoryName;
  CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children:<Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl,width: 120,height: 60,fit: BoxFit.cover,)),
            Container(
              alignment:Alignment.center ,
              width: 120,height: 60,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),

              child: Text(categoryName,style: TextStyle(
                color: Colors.white,
                    fontSize: 14,
                fontWeight: FontWeight.w500,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc;
  const BlogTile({Key? key, required this.imageUrl, required this.title, required this.desc}) : super(key: key);
    @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[ 
          Image.network(imageUrl),
          Text(title),
          Text(desc)
        ],
      ),
    );
  }
}




