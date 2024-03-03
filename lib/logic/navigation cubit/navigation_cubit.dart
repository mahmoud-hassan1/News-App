import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newsapp/screens/Home.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(HomeState());
  NewsListChanger(){
    emit(ArticleListState());
  }
  HomeChanger(){
    emit(HomeState());
  }
}
