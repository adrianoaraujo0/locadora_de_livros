import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/rent.dart';

class RentService{

  String token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJsaWJyYXJ5V0RBQGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfQURNSU4iXSwiaXNzIjoiaHR0cDovL3dkYS5ob3B0by5vcmc6ODA2Ni9hcGkvYXV0aGVudGljYXRpb24vbG9naW4iLCJleHAiOjE2NzU0NjAzMTh9.zj05ztkc-eJPrP991tlOgCtn8xC_K4qM8QKDNqQHdj8";
  
 Future<List<Rent>> getRent() async{
    try{
      http.Response response;
      response = await http.get(Uri.parse("http://wda.hopto.org:8066/api/rents/list"), headers: {"Authorization": token});

      if(response.body.isEmpty)return [];

      List<dynamic> listRentInJson =  jsonDecode(response.body);
      List<Rent> rents = listRentInJson.map((rent) => Rent.fromMap(rent)).toList();
      
      return rents;

    }catch(e){
      log("ERRO RENT SERVICE: $e");
      return [];
    }
  }

}