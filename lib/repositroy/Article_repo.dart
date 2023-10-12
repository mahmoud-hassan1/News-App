

import '../http webservice/http_request.dart';
import '../models/article.dart';

class Article_repo{


  http_request article_request;
  Article_repo({ required this.article_request});
  Future<List<Article>> getallarticles(String endPoint)async {
    List<Article>articles=[];
    var articlesAsJSon = await article_request.getData(endPoint);
    for(var json in articlesAsJSon){

      try {
        Article article = Article.fromjson(json);

        articles.add(article);
      }
      catch(e){
        print(e);
      }
    }
print("repo "+articles[0].title);
    return articles;
  }
}

