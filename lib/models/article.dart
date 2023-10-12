class Article{
final String title,description,url,urlimg,date,name;
Article.fromjson(Map <String,dynamic>json):
  name =json["source"]["name"],

  title=json['title'],
  description=json['description'],
  url=json['url'],
  urlimg=json['urlToImage'],
  date=json['publishedAt'];

}