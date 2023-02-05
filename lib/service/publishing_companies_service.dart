import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:locadora_de_livros/main_controller.dart';


class PublishingCompaniesService{
MainController mainController = MainController();

PublishingCompany publishingCompany = PublishingCompany();  

 Future<List<PublishingCompany>> getPublishingCompanies() async{
    try{
      Response response = await Dio().get("http://wda.hopto.org:8066/api/publishing-company/list",options: Options(contentType: 'application/json', headers:{ "Authorization": mainController.token}),);
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
        options: Options(contentType: 'application/json', headers:{ "Authorization": mainController.token}),
        data: {'name': name}
      );
      
      log("**************** POST PUBLI SERVICE ****************");
      log("RESPONSE DATA: ${response.data}");
      log("STATUS CODE: ${response.statusCode}");
      log("**************** POST PUBLI SERVICE ****************");
      log("${response.statusCode}");

    }on DioError catch(e){
      log("**************** POST PUBLI SERVICE ****************");
      log("ERRO STATUS CODE: ${e.response?.statusCode}");
      log("**************** POST PUBLI SERVICE ****************");
    }
    
  }

}