import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/widgets/main_controller.dart';

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



 Future<void> postClient() async{
    try{
      Client client = Client(
        name: "Bruna",
        birthDate: "2000-08-12", 
        cpf: "796.740.420-32",
        email: "Bru@gmail.com",
        password: "123456",
        position: "PEOPLE",
        userName: "Bru@gmail.com",
        profilePicture: ""
      );

      FormData data = FormData.fromMap(
        {
        "name": "Bruna",
        "birthDate": "2000-08-12", 
        "cpf": "796.740.420-32",
        "email": "Bru@gmail.com",
        "password": "123456",
        "position": "PEOPLE",
        "userName": "Bru@gmail.com",
        }
      );
  
     Response response = await Dio().post(
        "http://wda.hopto.org:8066/api/clients",
        options: Options(
           method: 'POST',
          validateStatus: (_) => true,
          headers:{ "Authorization": mainController.token, Headers.contentTypeHeader: "multipart/form-data"},
        ),
        data: data
      );
      
      print(response.data);
      log("${response.statusCode}");

    }on DioError catch(e){
      log("POST CLIENT SERVICE: ${e.response?.statusMessage}");
    }
    
  }

}