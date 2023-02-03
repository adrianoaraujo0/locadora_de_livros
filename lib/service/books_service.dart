import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/book.dart';

class BooksService{

String token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJsaWJyYXJ5V0RBQGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfQURNSU4iXSwiaXNzIjoiaHR0cDovL3dkYS5ob3B0by5vcmc6ODA2Ni9hcGkvYXV0aGVudGljYXRpb24vbG9naW4iLCJleHAiOjE2NzU0MzU2OTZ9.9bYBjhAL80iaELzfsMH8-7sYzmg4oN736APd8yivndw";

 Future<List<Book>> getBooks() async{
    try{
      http.Response response;
      response = await http.get(Uri.parse("http://wda.hopto.org:8066/api/books/list"), headers: {"Authorization": token});
      
      if(response.body.isEmpty)return [];
      
      List<dynamic> listBooksInJson =  jsonDecode(response.body);
      List<Book> books = listBooksInJson.map((book) => Book.fromMap(book)).toList();

      return books;
    }catch(e){
        return [];
    }
  }

}