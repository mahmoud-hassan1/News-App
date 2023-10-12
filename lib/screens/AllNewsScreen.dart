import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newsapp/screens/ArticleList.dart';
import 'package:newsapp/screens/Home.dart';


import '../logic/cubit/article_cubit.dart';
import '../models/article.dart';

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({Key? key}) : super(key: key);

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  late double height;
  int selectedIndex = 0;
  bool isLoading=false;
  List<Article> articles=[];
 List<Article>searchedArticles=[];
  final searchTextController=TextEditingController();
  @override
  void   initState(){
    super.initState();
  BlocProvider.of<ArticleCubit>(context).getallarticles("general");

  }
 void switchPage(int index)async{
    await BlocProvider.of<ArticleCubit>(context).getallarticles("general");
    setState(() {
      selectedIndex= index;
    });
   isLoading=false;
 }
  void searchedForArticles(String title) {
    searchedArticles= articles
      .where((product) => product.title.toLowerCase().contains(title.toLowerCase()))
      .toList();
    setState(() { });
  }

  Widget BuildBlocWidget(){
    return BlocBuilder<ArticleCubit,ArticleState>(
        builder:( context ,state){
          if(state is GeneralLoaded  ){
            articles=(state).articles;
            return buildLoadedListWidget()  ;
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
Widget buildLoadedListWidget(){

  return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: selectedIndex == 1 ? ArticleList(
      searchTextController: searchTextController,
      searchedArticles: searchedArticles,
      articles: articles)
      : Home(articles: articles,
      searchedArticles: searchedArticles,
      searchTextController: searchTextController,
        height: height,
      )
  );
}
  @override
  Widget build(BuildContext context) {
       height=MediaQuery.of(context).size.height -    // total height
          kToolbarHeight -                      // top AppBar height
          MediaQuery.of(context).padding.top -  // top padding
          kBottomNavigationBarHeight;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'News list',
          ),
        ],
          currentIndex: selectedIndex,
        onTap:  (index){
          articles.length==0?
              setState((){
                BlocProvider.of<ArticleCubit>(context).getallarticles("general");
            selectedIndex=index;
          }) :
          setState(() {
            isLoading=true;
            switchPage(index);
          });

        }
      ),
      body:  BuildBlocWidget(),
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
                articles.length==0?SizedBox()
              :searchedForArticles(value);
            },
          ),
        ),
      ),
    );
  }
}
