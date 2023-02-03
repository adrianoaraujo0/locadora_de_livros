import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/book.dart';

class BooksService{

String token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJsaWJyYXJ5V0RBQGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfQURNSU4iXSwiaXNzIjoiaHR0cDovL3dkYS5ob3B0by5vcmc6ODA2Ni9hcGkvYXV0aGVudGljYXRpb24vbG9naW4iLCJleHAiOjE2NzU0NjAzMTh9.zj05ztkc-eJPrP991tlOgCtn8xC_K4qM8QKDNqQHdj8";

   Future<List<Book>> getBooks() async{
    try{
      Response response = await Dio().get("http://wda.hopto.org:8066/api/books/list",options: Options(contentType: 'application/json', headers:{ "Authorization": token}),);
      if(response.data.isEmpty)return [];
      List<dynamic> listBookInJson =  response.data;
      List<Book> books = listBookInJson.map((book) => Book.fromMap(book)).toList();
      return books;
    }catch(e){
      log("ERRO PUBLISHING SERVICE $e");
      return [];
    }
  }

  Future<void> postBook(Book book) async{
    try{
     Response response = await Dio().post(
        "http://wda.hopto.org:8066/api/books",
        options: Options(contentType: 'application/json', headers:{ "Authorization": token}),
        data: book.toMap());
      
      print("POST BOOKS SERVICE RESPONSE DATA: ${response.data}");
      log("${response.statusCode}");

    }on DioError catch(e){
      log("POST BOOKS SERVICE: ${e.response?.statusCode}");
    }
    
  }

}