import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newsapp/screens/widgets/ArticleInHome.dart';
import '../logic/cubit/article_cubit.dart';
import '../models/article.dart';

class Home extends StatelessWidget {
   List<Article> articles=[];
  List<Article> searchedArticles=[];
  final searchTextController;
  double height;


  Home({Key? key,
    required this.searchTextController,
    required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    BlocProvider.of<ArticleCubit>(context).getallarticles("general");
    return BlocConsumer<ArticleCubit, ArticleState>(
        listener: (context, state) {
      if (state is GeneralLoading) {
        isLoading = true;
      } else if (state is GeneralLoaded) {
        isLoading = false;
        articles = BlocProvider.of<ArticleCubit>(context).articles;
      } else if (state is Generalfaild) {
        isLoading = true;
      } else if (state is SearchingState) {
        searchedArticles =
            BlocProvider.of<ArticleCubit>(context).searchedArticles;
      }
    },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: height - 25.h,
                  child: Center(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            height: 20.h,
                          ),
                      scrollDirection: Axis.horizontal,
                      itemCount: searchedArticles.length==0
                          ? articles.length
                          : searchedArticles.length,
                      itemBuilder: (context, index) =>
                          ArticleInHome(
                              article: searchedArticles.length==0
                                  ? articles[index]
                                  : searchedArticles[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
