import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:locadora_de_livros/model/rent.dart';
import 'package:locadora_de_livros/main_controller.dart';

class RentService{

MainController mainController = MainController();
  
 

  Future<List<Rent>> getRents() async{
    try{
      Response response = await Dio().get("http://wda.hopto.org:8066/api/rents/list",options: Options(contentType: 'application/json', headers:{ "Authorization": mainController.token}),);
      if(response.data.isEmpty)return [];
      List<dynamic> listRent =  response.data;
      List<Rent> rents = listRent.map((rent) => Rent.fromMap(rent)).toList();
      return rents;
    }on DioError catch(e){
      log("POST BOOKS SERVICE: ${e.response?.statusCode}");
      return [];
    }
  }


  Future<void> postBook(Rent rent) async{
    try{
     Response response = await Dio().post(
        "http://wda.hopto.org:8066/api/rents",
        options: Options(contentType: 'application/json', headers:{ "Authorization": mainController.token}),
        data: rent.toMap()
      );

      log("**************** POST RENT SERVICE ****************");
      log("RESPONSE DATA: ${response.data}");
      log("STATUS CODE: ${response.statusCode}");
      log("**************** POST RENT SERVICE ****************");

    }on DioError catch(e){
      log("**************** POST RENT SERVICE ****************");
      log("ERRO: ${e}");
      log("**************** POST RENT SERVICE ****************");
    }
  }

    Future<void> putBook(String id) async{
      print("ENTROU NO PUT");
    try{
     Response response = await Dio().put(
        "http://wda.hopto.org:8066/api/rents",
        options: Options(contentType: 'application/json', headers:{ "Authorization": mainController.token}),
        data: {"id": id}
      );

      log("**************** PUT RENT SERVICE ****************");
      log("RESPONSE DATA: ${response.data}");
      log("STATUS CODE: ${response.statusCode}");
      log("**************** PUT RENT SERVICE ****************");

    }on DioError catch(e){
      log("**************** PUT RENT SERVICE ****************");
      log("ERRO: ${e}");
      log("**************** PUT RENT SERVICE ****************");
    }
  }

}