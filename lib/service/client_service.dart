import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/main_controller.dart';
import 'package:path_provider/path_provider.dart';

class ClientService{
 MainController mainController = MainController();
  
  Future<List<Client>> getClients() async{
    try{
      Response response = await Dio().get("http://wda.hopto.org:8066/api/clients/clients/active",options: Options(contentType: 'application/json', headers:{ "Authorization": mainController.token}));
      if(response.data.isEmpty)return [];
      List<dynamic> listClient =  response.data;
      List<Client> clients = listClient.map((client) => Client.fromMap(client)).toList();
      
      log("**************** GET CLIENT SERVICE ****************");
      log("RESPONSE DATA: ${response.data}");
      log("STATUS CODE: ${response.statusCode}");
      log("**************** GET CLIENT SERVICE ****************");

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
      FormData formData = FormData.fromMap(
        {
          "id": "beb54b23-70fd-454d-a5b7-525a59d0d16d",
         "name": "MARIA SILVA BARRETO", 
         "email": "Maria@gmail.com",
          "birthDate": "1999-01-21", 
         "cpf": "411.639.920-54", 
         "position": "PEOPLE",
          "userUpdateRequest.username": "Maria@gmail.com",
          "userUpdateRequest.password": "12345678",
          "userUpdateRequest.id":"7f0b39c3-ee9c-4d8b-8bfc-ab1d46981e0c"
        }
      );
     Response response = await Dio().put(
        "http://wda.hopto.org:8066/api/clients",
        options: Options(
          headers:{ "Authorization": mainController.token, "Content-Type": "*/*", "accept":"*/*"},
        ),
        data: await client.toPutFormData()
      );

      log("**************** PUT CLIENT SERVICE ****************");
      log("RESPONSE DATA: ${response.data}");
      log("STATUS CODE: ${response.statusCode}");
      log("**************** PUT CLIENT SERVICE ****************");

    }on DioError catch(e){
      log("PUT CLIENT SERVICE: $e");
    }
  }

 Future<Client> getClientById(String id) async{
    try{
     Response response = await Dio().get(
        "http://wda.hopto.org:8066/api/clients/$id",
        options: Options(contentType: 'application/json',headers:{ "Authorization": mainController.token}),
      );

      Directory appDocDir = await getApplicationDocumentsDirectory();
      print(response.data['profilePicture']);
      
      String? imageName;
      Response? responseDownload;

      if(response.data['profilePicture'] != null){
        imageName = response.data['profilePicture']['name'];
        
        responseDownload = await Dio().download(
          "http://wda.hopto.org:8066/api/clients/$id",
          "${appDocDir.path}/$imageName",
          options: Options( headers:{ "Authorization": mainController.token})
         );
      }
      Client client = Client.fromMap({
        "id": response.data['id'],
        "name": response.data['name'],
        "email": response.data['email'],
        "birthDate": DateTime.parse(response.data['birthDate']),
        "cpf": response.data["cpf"],
        "position": response.data['position'],
        "profilePicture": imageName != null ? "${appDocDir.path}/$imageName" : null ,
        "userCreateRequest.userName": response.data['user']['username'],
        "userUpdateRequest.id": response.data['user']['id']
      });

      log("**************** GETBY ID CLIENT SERVICE ****************");
      log("UserId: ${client.toString()}}");
      log("RESPONSE DATA: ${response.data}");
      log("STATUS CODE: ${response.statusCode}");
      log("******************************************************");
      log("RESPONSE DOWNLOAD: ${responseDownload?.statusCode}");
      log("**************** GETBY ID CLIENT SERVICE ****************");

      return client;
    }on DioError catch(e){
      log("POST CLIENT SERVICE: $e");
      return Client();
    }
  }



}