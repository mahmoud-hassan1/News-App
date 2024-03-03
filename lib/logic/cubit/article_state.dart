part of 'article_cubit.dart';

@immutable
abstract class ArticleState {}

class ArticleInitial extends ArticleState {}
class GeneralLoaded extends ArticleState {
}
class Generalfaild extends ArticleState {
final String msg;
Generalfaild(this.msg);
}
class GeneralLoading extends ArticleState {}
class SearchingState extends ArticleState {}
