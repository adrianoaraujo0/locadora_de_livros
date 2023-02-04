import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/service/client_service.dart';
import 'package:rxdart/rxdart.dart';

class ListClientController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final myFocusNodes = FocusNode();

  BehaviorSubject<List<Client>> streamClient = BehaviorSubject<List<Client>>();
  ClientService clientService = ClientService();
  List<Client> clients = [];

  Future<void> initListClientPage() async{
    clients = await clientService.getClients();
    streamClient.sink.add(clients);
  }

   void search(String value){
    List<Client> listFilter = clients.where((element) => element.name!.toUpperCase().contains(value.toUpperCase())).toList();
    streamClient.sink.add(listFilter);
  }

}