import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:rxdart/rxdart.dart';

class ListPublishingCompanyController{

  BehaviorSubject<PublishingCompany> streamPublishingCompany = BehaviorSubject<PublishingCompany>();

  TextEditingController publishingCompanyController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validationForm( BuildContext context, PublishingCompany publishingCompany){
    if(publishingCompany.name == null || publishingCompany.name!.isEmpty){
       formKey.currentState!.validate();
    }else{
      streamPublishingCompany.sink.add(publishingCompany);
    }
  }

}