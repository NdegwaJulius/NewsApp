class ArticleModel{
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  //DateTime publishedAt = DateTime.now();

  ArticleModel({required this.title,required this.author,required this.description,required this.content,required this.url,required this.urlToImage, required articleUrl}) {
    // TODO: implement
    throw UnimplementedError();
  }
}