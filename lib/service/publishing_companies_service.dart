import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:locadora_de_livros/model/publishing_company.dart';


class PublishingCompaniesService{

String token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJsaWJyYXJ5V0RBQGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfQURNSU4iXSwiaXNzIjoiaHR0cDovL3dkYS5ob3B0by5vcmc6ODA2Ni9hcGkvYXV0aGVudGljYXRpb24vbG9naW4iLCJleHAiOjE2NzU0MzU2OTZ9.9bYBjhAL80iaELzfsMH8-7sYzmg4oN736APd8yivndw";
PublishingCompany publishingCompany = PublishingCompany();  

 Future<List<PublishingCompany>> gePublishingCompanies() async{
    try{
      http.Response response;
      response = await http.get(Uri.parse("http://wda.hopto.org:8066/api/publishing-company/list"), headers: {"Authorization": token});

      if(response.body.isEmpty)return [];

      List<dynamic> listPublishingCompanyInJson =  jsonDecode(response.body);
      List<PublishingCompany> publishingCompanies = listPublishingCompanyInJson.map((book) => PublishingCompany.fromMap(book)).toList();

      return publishingCompanies;
    }catch(e){
      log("ERRO PUBLISHING SERVICE $e");
      return [];
    }
    
  }

}