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
    publishingCompanies = await publishingCompaniesService.getPublishingCompanies();
    streamPublishingCompany.sink.add(publishingCompanies);
  }

  void validationForm( BuildContext context) async{
    if(publishingCompanyController.text.isEmpty){
       formKey.currentState!.validate();
    }else{
      savePublishingCompany(publishingCompanyController.text);
      publishingCompanyController.clear();
      await initListPublishingCompanyController();
      Navigator.pop(context);
    }
  }

  Future<void> savePublishingCompany(String name) async{
    await publishingCompaniesService.postPublishingCompany(name);
    await initListPublishingCompanyController();
  }

  void search(String value){
   List<PublishingCompany> listFilter = publishingCompanies.where((element) => element.name!.toUpperCase().contains(value.toUpperCase())).toList();
   streamPublishingCompany.sink.add(listFilter);
  }

}