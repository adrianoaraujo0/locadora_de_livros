import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:locadora_de_livros/service/publishing_companies_service.dart';
import 'package:rxdart/rxdart.dart';

class ListPublishingCompanyController{

  BehaviorSubject<List<PublishingCompany>> streamPublishingCompany = BehaviorSubject<List<PublishingCompany>>();
  PublishingCompaniesService publishingCompaniesService = PublishingCompaniesService();

  TextEditingController publishingCompanyController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  List<PublishingCompany> publishingCompanies = [];

  Future<void> initListPublishingCompanyController() async{
    print("vai cadastrar");
    // publishingCompanies = await publishingCompaniesService.getPublishingCompanies();
    List<PublishingCompany> publishingCompany = [PublishingCompany(name: "Makron")];
    streamPublishingCompany.sink.add(publishingCompany);
  }

  void validationForm( BuildContext context){
    if(publishingCompanyController.text.isEmpty){
       formKey.currentState!.validate();
    }else{
      savePublishingCompany(publishingCompanyController.text);
      Navigator.pop(context);
    }
  }

  Future<void> savePublishingCompany(String name) async{
    await publishingCompaniesService.postPublishingCompany(name);
    await initListPublishingCompanyController();
  }

  void search(String value){
   List<PublishingCompany> listFilter = publishingCompanies.where((element) => element.name!.contains(value)).toList();
   streamPublishingCompany.sink.add(listFilter);
  }

}