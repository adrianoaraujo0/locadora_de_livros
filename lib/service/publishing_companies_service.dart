import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/publishing_company.dart';


class PublishingCompaniesService{

String token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJsaWJyYXJ5V0RBQGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfQURNSU4iXSwiaXNzIjoiaHR0cDovL3dkYS5ob3B0by5vcmc6ODA2Ni9hcGkvYXV0aGVudGljYXRpb24vbG9naW4iLCJleHAiOjE2NzU0NjAzMTh9.zj05ztkc-eJPrP991tlOgCtn8xC_K4qM8QKDNqQHdj8";
PublishingCompany publishingCompany = PublishingCompany();  

 Future<List<PublishingCompany>> getPublishingCompanies() async{
    try{
      Response response = await Dio().get("http://wda.hopto.org:8066/api/publishing-company/list",options: Options(contentType: 'application/json', headers:{ "Authorization": token}),);
      if(response.data.isEmpty)return [];
      List<dynamic> listPublishingCompanyInJson =  response.data;
      List<PublishingCompany> publishingCompanies = listPublishingCompanyInJson.map((book) => PublishingCompany.fromMap(book)).toList();
      return publishingCompanies;
    }catch(e){
      log("ERRO PUBLISHING SERVICE $e");
      return [];
    }
  }

  Future<void> postPublishingCompany(String name) async{
    try{
     Response response = await Dio().post(
        "http://wda.hopto.org:8066/api/publishing-company",
        options: Options(contentType: 'application/json', headers:{ "Authorization": token}),
        data: {'name': name}
      );
      
      print("POST PUBLI SERVICE RESPONSE DATA: ${response.data}");
      log("${response.statusCode}");

    }on DioError catch(e){
      log("POST PUBLI SERVICE: ${e.response?.statusCode}");
    }
    
  }

}