import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/client.dart';

class ClientService{

  String token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJsaWJyYXJ5V0RBQGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfQURNSU4iXSwiaXNzIjoiaHR0cDovL3dkYS5ob3B0by5vcmc6ODA2Ni9hcGkvYXV0aGVudGljYXRpb24vbG9naW4iLCJleHAiOjE2NzU0NjAzMTh9.zj05ztkc-eJPrP991tlOgCtn8xC_K4qM8QKDNqQHdj8";
  
 Future<List<Client>> getClient() async{
    try{
      http.Response response;
      response = await http.get(Uri.parse("http://wda.hopto.org:8066/api/clients/clients/active"), headers: {"Authorization": token});

      if(response.body.isEmpty)return [];
      
      List<dynamic> listClientInJson =  jsonDecode(response.body);

      List<Client> clients = listClientInJson.map((client) => Client.fromMap(client)).toList();
      return clients;

    }catch(e){
       log("ERRO CLIENT SERVICE $e");
      return [];
    }
  }

//  Future<void> postClient() async{
//     try{
//       http.Response response;
//       Client client = Client(
//         name: "Bruna",
//         birthDate: "2000-08-12", 
//         cpf: "796.740.420-32",
//         email: "Bru@gmail.com",
//         password: "123456",
//         position: "PEOPLE",
//         userName: "Bru@gmail.com",
//         profilePicture: ""
//       );
//     String clientJson = jsonEncode(client.toMap());
//      response = await http.post(
//         Uri.parse("http://wda.hopto.org:8066/api/clients"), 
//         headers: {
//           "Authorization": token,
//         },
//         body: Client(
//           name: "Bruna",
//           birthDate: "2000-08-12", 
//           cpf: "796.740.420-32",
//           email: "Bru@gmail.com",
//           password: "123456",
//           position: "PEOPLE",
//           userName: "Bru@gmail.com",
//           profilePicture: ""
//         ).toMap()
//       );
      
//       print(response.body);
//       log("${response.statusCode}");

//     }catch(e){
//       log("POST CLIENT SERVICE: $e");
//     }
    
//   }
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
          headers:{ "Authorization": token, Headers.contentTypeHeader: "multipart/form-data"},
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