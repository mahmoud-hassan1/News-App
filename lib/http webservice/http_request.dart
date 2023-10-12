import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:newsapp/Constants/Constants.dart';

class http_request{
 late Dio dio;
http_request(){
  BaseOptions options= BaseOptions(
    baseUrl: "https://newsapi.org/v2/",
      receiveDataWhenStatusError: true,
  
  );
  dio=Dio(options);
}


  Future<dynamic> getData(String endPoint) async {
try {
  Response response = await dio.get(
        "top-headlines?country=us&category="+endPoint+key);
    print(endPoint);
    print(response.data);
  return response.data["articles"];
}
catch(e){
  print (e);
  return [];
}
 }
}
