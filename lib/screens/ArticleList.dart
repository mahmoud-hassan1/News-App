import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newsapp/screens/widgets/ArticleInListView.dart';

import '../logic/cubit/article_cubit.dart';
import '../models/article.dart';

class ArticleList extends StatefulWidget {
  late List<Article> articles;
  List<Article> searchedArticles;
  final searchTextController;
  ArticleList({
    Key? key,
    required this.searchTextController,
    required this.searchedArticles,
    required this.articles,
  }) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  int selectedcategory = 0;
  List<String> category = [
    "general",
    "business",
    "health",
    "science",
    "sports",
    "technology"
  ];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(children: [
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 33.h,
            child: ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await BlocProvider.of<ArticleCubit>(context)
                              .getallarticles(category[index]);
                          isLoading = false;
                          selectedcategory = index;
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: selectedcategory == index
                              ? Colors.blue.shade800
                              : Colors.blue,
                        ),
                        child: Text(category[index]),
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      width: 15.w,
                    ),
                itemCount: category.length),
          ),
          SizedBox(height: 15.h),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                    height: 20.h,
                  ),
              scrollDirection: Axis.vertical,
              itemCount: widget.searchTextController.text.isEmpty
                  ? widget.articles.length
                  : widget.searchedArticles.length,
              itemBuilder: (context, index) => ArticlInLIstView(
                  article: widget.searchTextController.text.isEmpty
                      ? widget.articles[index]
                      : widget.searchedArticles[index]))
        ]),
      ),
    );
  }
}
