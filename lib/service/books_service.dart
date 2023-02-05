import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/main_controller.dart';

class BooksService{

MainController mainController = MainController();


   Future<List<Book>> getBooks() async{
    try{
      Response response = await Dio().get("http://wda.hopto.org:8066/api/books/list",options: Options(contentType: 'application/json', headers:{ "Authorization": mainController.token}),);
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
        options: Options(contentType: 'application/json', headers:{ "Authorization": mainController.token}),
        data: book.toMap());

      log("**************** POST BOOKS SERVICE ****************");
      log("RESPONSE DATA: ${response.data}");
      log("STATUS CODE: ${response.statusCode}");
      log("**************** POST BOOKS SERVICE ****************");

    }on DioError catch(e){
      log("**************** POST BOOKS SERVICE ****************");
      log("ERRO: ${e.response?.statusCode}");
      log("**************** POST BOOKS SERVICE ****************");
    }
  }

}