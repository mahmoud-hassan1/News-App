import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/logic/navigation%20cubit/navigation_cubit.dart';
import 'package:newsapp/repositroy/Article_repo.dart';
import 'package:newsapp/screens/AllNewsScreen.dart';

import 'http webservice/http_request.dart';
import 'logic/cubit/article_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Article_repo  article_repo=Article_repo(article_request:http_request() );
    ArticleCubit articleCubit=ArticleCubit(article_repo);
    return MultiBlocProvider(
      providers: [
        BlocProvider
          (create: (BuildContext context)=>
            ArticleCubit(article_repo),
        ),
        BlocProvider(create: (context) => NavigationCubit() ,)
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false ,
          home: AllNewsScreen()
        ),
      ),
    );
  }
}



