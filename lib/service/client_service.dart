import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/main_controller.dart';

class ClientService{
 MainController mainController = MainController();
  
  Future<List<Client>> getClients() async{
    try{
      Response response = await Dio().get("http://wda.hopto.org:8066/api/clients/clients/active",options: Options(contentType: 'application/json', headers:{ "Authorization": mainController.token}));
      if(response.data.isEmpty)return [];
      List<dynamic> listClient =  response.data;
      List<Client> clients = listClient.map((client) => Client.fromMap(client)).toList();
      return clients;
    }catch(e){
      log("ERRO PUBLISHING SERVICE $e");
      return [];
    }
  }



 Future<void> postClient(Client client) async{
    try{

     Response response = await Dio().post(
        "http://wda.hopto.org:8066/api/clients",
        options: Options(
          headers:{ "Authorization": mainController.token, "Content-Type": "multipart/form-data", "accept":"*/*"},
        ),
        data: await client.toPostFormData()
      );

      log("**************** POST CLIENT SERVICE ****************");
      log("RESPONSE DATA: ${response.data}");
      log("STATUS CODE: ${response.statusCode}");
      log("**************** POST CLIENT SERVICE ****************");

    }on DioError catch(e){
      log("POST CLIENT SERVICE: ${e}");
    }
  }

 Future<void> putClient(Client client) async{
    try{
     Response response = await Dio().put(
        "http://wda.hopto.org:8066/api/clients",
        options: Options(
          headers:{ "Authorization": mainController.token, "Content-Type": "multipart/form-data", "accept":"*/*"},
        ),
        data: await client.toPostFormData()
      );

      log("**************** POST CLIENT SERVICE ****************");
      log("RESPONSE DATA: ${response.data}");
      log("STATUS CODE: ${response.statusCode}");
      log("**************** POST CLIENT SERVICE ****************");

    }on DioError catch(e){
      log("POST CLIENT SERVICE: $e");
    }
  }

}