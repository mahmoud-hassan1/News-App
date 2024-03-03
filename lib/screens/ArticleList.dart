import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newsapp/screens/widgets/ArticleInListView.dart';

import '../logic/cubit/article_cubit.dart';
import '../models/article.dart';

class ArticleList extends StatelessWidget {
  List<Article> articles=[];
  List<Article> searchedArticles;
  final searchTextController;
  ArticleList({
    Key? key,
    required this.searchTextController,
    required this.searchedArticles,

  }) : super(key: key);

  int selectedcategory = 0;
  List<String> category = [
    "general",
    "business",
    "health",
    "science",
    "sports",
    "technology"
  ];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ArticleCubit>(context).getallarticles(category[0]);
    return BlocConsumer<ArticleCubit, ArticleState>(
  listener: (context, state) {
    if(state is GeneralLoading){
      isLoading=true;
    }
    else if(state is GeneralLoaded){
      isLoading=false;
      articles=BlocProvider.of<ArticleCubit>(context).articles;
    }else if(state is Generalfaild){
      isLoading=true;
    }
    else if(state is SearchingState){
      searchedArticles=BlocProvider.of<ArticleCubit>(context).searchedArticles;
    }
  },
  builder: (context, state) {
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
                          selectedcategory = index;
                           BlocProvider.of<ArticleCubit>(context)
                              .getallarticles(category[index]);

                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: selectedcategory == index
                              ? Colors.blue.shade800
                              : Colors.blue,
                        ),
                        child: Text(category[index],
                          style: TextStyle(
                              color: Colors.white
                          )
                        ),
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
              itemCount: searchedArticles.length==0
                  ? articles.length
                  : searchedArticles.length,
              itemBuilder: (context, index) => ArticlInLIstView(
                  article: searchedArticles.length==0
                      ? articles[index]
                      : searchedArticles[index]))
        ]),
      ),
    );
  },
);
  }
}
