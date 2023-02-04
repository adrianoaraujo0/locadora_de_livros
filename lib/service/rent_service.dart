import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/rent.dart';
import 'package:locadora_de_livros/widgets/main_controller.dart';

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

}