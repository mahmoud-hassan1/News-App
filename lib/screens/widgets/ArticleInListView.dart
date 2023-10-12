import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/article.dart';
import '../ArticleDetails.dart';

    class ArticlInLIstView extends StatelessWidget {
Article article;
ArticlInLIstView({required this.article});

      @override
      Widget build(BuildContext context) {
        return  GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetails(article: article),));
          },
          child: Container(
            height: 110.h,
            width: double.infinity,
            margin: EdgeInsets.only(
              right: 10.w,
              left: 10.w,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 5.h
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
              BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 5,
            )
              ],
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90.w,
                  height: 110.h,
                  child:
                  CachedNetworkImage(
                            imageUrl: article.urlimg,
                            fit: BoxFit.fill,
                    errorWidget: (context, url, error) => Icon(Icons.error),

                  ),
                ),


                SizedBox(width: 5.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp
                        ),
                      ),
                      Text(
                          article.date,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Flexible(
                        child: Text(
                          maxLines: 2,
                            article.description,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp
                          ),

                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ) ;
      }


}
