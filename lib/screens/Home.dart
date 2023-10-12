import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/screens/widgets/ArticleInHome.dart';
import '../models/article.dart';

class Home extends StatelessWidget {
  late List<Article> articles;
  List<Article> searchedArticles;
  final searchTextController;
  double height;
  Home({Key? key, required this.articles, required this.searchedArticles, required this.searchTextController,required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: height-25.h,
            child: Center(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.h,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: searchTextController.text.isEmpty
                    ? articles.length
                    : searchedArticles.length,
                itemBuilder: (context, index) => ArticleInHome(
                    article: searchTextController.text.isEmpty
                        ? articles[index]
                        : searchedArticles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
