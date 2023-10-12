import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newsapp/Constants/Constants.dart';

import '../../models/article.dart';
import '../../repositroy/Article_repo.dart';







part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
   Article_repo article_repo;

  ArticleCubit(this.article_repo) : super(ArticleInitial());

Future< void> getallarticles(String endPoint){
   return  article_repo.getallarticles(endPoint).then((articles) {

      emit(GeneralLoaded(articles));
    });
  }
}
