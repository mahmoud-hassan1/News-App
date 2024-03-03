import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newsapp/Constants/Constants.dart';

import '../../models/article.dart';
import '../../repositroy/Article_repo.dart';







part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  Article_repo article_repo;
  late List<Article> searchedArticles;
  ArticleCubit(this.article_repo) : super(ArticleInitial());
  late List<Article> articles;

  Future<void> getallarticles(String endPoint) async {
    emit(GeneralLoading());
    try {
      articles = await article_repo.getallarticles(endPoint);
      emit(GeneralLoaded());
    }
    catch (x) {
      emit(Generalfaild("Some thing went wrong try again later"));
    }
  }
  SearchArticle(title){
    searchedArticles= articles.where((product) => product.title.toLowerCase().contains(title.toLowerCase())).toList();
    emit(SearchingState());
  }
}
