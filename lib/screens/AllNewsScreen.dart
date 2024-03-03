import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newsapp/screens/ArticleList.dart';
import 'package:newsapp/screens/Home.dart';


import '../logic/cubit/article_cubit.dart';
import '../logic/navigation cubit/navigation_cubit.dart';
import '../models/article.dart';

class AllNewsScreen extends StatelessWidget {
  AllNewsScreen({Key? key}) : super(key: key);
  late double height;
  int selectedIndex = 0;
  bool isLoading=false;
  List<Article> articles=[];
 List<Article>searchedArticles=[];


  @override

 // void switchPage(int index)async{
 //    await BlocProvider.of<ArticleCubit>(context).getallarticles("general");
 //    setState(() {
 //      selectedIndex= index;
 //    });
 //   isLoading=false;
 //}
 //  void searchedForArticles(String title) {
 //    searchedArticles= articles
 //      .where((product) => product.title.toLowerCase().contains(title.toLowerCase()))
 //      .toList();
 //  
 //  }


  @override
  Widget build(BuildContext context) {
       height=MediaQuery.of(context).size.height -    // total height
          kToolbarHeight -                      // top AppBar height
          MediaQuery.of(context).padding.top -  // top padding
          kBottomNavigationBarHeight;
    return BlocBuilder<NavigationCubit, NavigationState>(
  builder: (context, state) {
    final  searchTextController=BlocProvider.of<ArticleCubit>(context).searchTextController;
      print(searchTextController.value.text);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.home_filled,
              ),
              label: "Home",

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list,
            ),
            label: 'News list',
          ),
        ],
          currentIndex: selectedIndex,
        selectedItemColor:Colors.purple ,
        onTap:  (index){
          selectedIndex=index;
          index ==0?BlocProvider.of<NavigationCubit>(context).HomeChanger():
          BlocProvider.of<NavigationCubit>(context).NewsListChanger();
        }
      ),
      body: state is HomeState ?
        Home(height: height)
      :ArticleList()

,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: EdgeInsets.fromLTRB(15.w, 5.h, 15.w,0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 10,
              ),
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius:3,
              )
            ],
          ),
          child: TextField(
            controller: searchTextController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
            ),
            onChanged: (value) {
              BlocProvider.of<ArticleCubit>(context).SearchArticle(value);
            },
            onSubmitted: (value) {
              BlocProvider.of<ArticleCubit>(context).SearchArticle(value);
              print("ssssss");
            },
          ),
        ),
      ),
    );
    }
    );
  }
}
