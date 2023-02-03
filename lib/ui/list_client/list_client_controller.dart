import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:rxdart/rxdart.dart';

class ListClientController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final myFocusNodes = FocusNode();

  BehaviorSubject<List<Client>> streamListClient = BehaviorSubject<List<Client>>();

}