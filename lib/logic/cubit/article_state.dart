part of 'article_cubit.dart';

@immutable
abstract class ArticleState {}

class ArticleInitial extends ArticleState {}
class GeneralLoaded extends ArticleState {

  final List<Article> articles;

  GeneralLoaded(this.articles);
}
class Generalfaild extends ArticleState {

}
