import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

class ArticleDetails extends StatelessWidget {
  final Article article;
  const ArticleDetails({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 90.h),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ]),
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: article.urlimg,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => Icon(Icons.error),

                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    Text(
                      article.date,
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      article.description,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    GestureDetector(
                        onTap: () async {
                          final url = article.url;
                          try {
                            await launch(url);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text(
                          article.url,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
