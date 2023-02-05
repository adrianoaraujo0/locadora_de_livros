import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/service/client_service.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rxdart/rxdart.dart';

class CreateUserController{

  BehaviorSubject<Client> streamForm = BehaviorSubject<Client>();
  BehaviorSubject<String?> streamPopMenuButtonPosition = BehaviorSubject<String?>();
  BehaviorSubject<bool> streamAddImage = BehaviorSubject<bool>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final myFocusNodes = FocusNode();
  
  MaskTextInputFormatter birthDateMask = MaskTextInputFormatter(mask: '##/##/####');
  MaskTextInputFormatter cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  String? position;

  ClientService clientService = ClientService();

   void clearAll(){
    nameController.clear();
    emailController.clear();
    cpfController.clear();
    birthDateController.clear();
    usernameController.clear();
    passwordController.clear();
    streamAddImage.sink.add(false);
    streamPopMenuButtonPosition.sink.add(null);
   }

   void validationForm(Client client, BuildContext context){
    client.toPostFormData().then((value) => print(value.fields));
    if(client.name == null || client.name!.isEmpty){
      alertSnackBar(context, "O nome do usuário está vazio.");

    }else if(client.email == null || client.email!.isEmpty || !client.email!.contains("@") || !client.email!.contains(".com")){
      alertSnackBar(context, "O email do usuário está inválido.");

    }else if(client.cpf == null || client.cpf!.isEmpty || client.cpf!.length < 14 ){
      alertSnackBar(context, "O cpf do usuário está inválido.");

    }else if(client.birthDate == null){
      alertSnackBar(context, "A data de nascimento está incorreta.");

    }else if(client.position == null || client.position!.isEmpty){
      alertSnackBar(context, "O cargo não foi selecionado.");

    }else if(client.userName == null || client.userName!.isEmpty){
      alertSnackBar(context, "O nome de login está vazio.");

    }else if(client.password == null || client.password!.isEmpty || client.password!.length < 6){
      alertSnackBar(context, "A senha deve conter no mínimo 6 caracteres.");
    }
    else {
      saveClient(client);
      clearAll();
      alertSnackBar(context, "Cliente cadastrado com sucesso", color: appColors.green);

    }
  }

  DateTime convertStringToDateTime(String date){

    String day = date.substring(0,2);
    String month = date.substring(3,5);
    String year = date.substring(6,10);
    
    return DateTime.parse("$year-$month-$day");
  }

  Future<void> saveClient(Client client) async{
    clientService.postClient(client);
  }

  ScaffoldFeatureController alertSnackBar(BuildContext context, String message, {Color color = appColors.red}){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

}