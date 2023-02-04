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
    // clients = await clientService.getClients();
    List<Client> clients = [
      Client(name: "Adriano araújo", email: "Adriano@g.com", birthDate: "12/08/2000", cpf: "081.050.434-12", position: "Cliente", userName: "Adriano@g.com", password: "123456"),
    ];
    streamClient.sink.add(clients);
  }

   void search(String value){
    List<Client> listFilter = clients.where((element) => element.name!.toUpperCase().contains(value.toUpperCase())).toList();
    streamClient.sink.add(listFilter);
  }

}