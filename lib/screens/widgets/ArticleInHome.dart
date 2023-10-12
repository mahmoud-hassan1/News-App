import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/article.dart';
import '../ArticleDetails.dart';

class ArticleInHome extends StatelessWidget {
  final Article article;
  const ArticleInHome({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetails(article: article),));
      },
      child: Container(

        margin: EdgeInsets.only(bottom: 10.h,right: 12.w,left: 12.w),
        height: double.infinity,
        width: MediaQuery.of(context).size.width-25.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: GridTile(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: article.urlimg,
          fit: BoxFit.fill,
          errorWidget: (context, url, error) => Icon(Icons.error),

        ),
      ),
      footer: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              article.title,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            ),
            SizedBox(height: 60.h,)
          ],
        ),
      ),
        ),
      ),
    );
  }
}
