import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rxdart/rxdart.dart';

class CreateUserController{

  BehaviorSubject<Client> streamForm = BehaviorSubject<Client>();
  BehaviorSubject<String> streamPopMenuButtonPosition = BehaviorSubject<String>();
  BehaviorSubject<bool> streamAddImage = BehaviorSubject<bool>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final myFocusNodes = FocusNode();
  
  MaskTextInputFormatter birthDateMask = MaskTextInputFormatter(mask: '##/##/####');
  MaskTextInputFormatter cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');

  TextEditingController nameController = TextEditingController();
  TextEditingController profilePictureController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  String? position;


   void validationForm(Client client, BuildContext context){
    log(client.toString());
    if(client.name == null || client.name!.isEmpty){
      alertSnackBar(context, "O nome do usuário está vazio.");

    }else if(client.email == null || client.email!.isEmpty || !client.email!.contains("@")){
      alertSnackBar(context, "O email do usuário está inválido.");

    }else if(client.cpf == null || client.cpf!.isEmpty || client.cpf!.length < 14 ){
      alertSnackBar(context, "O cpf do usuário está inválido.");

    }else if(client.birthDate == null){
      alertSnackBar(context, "A data de nascimento está incorreta.");

    }else if(client.position == null || client.position!.isEmpty){
      alertSnackBar(context, "O cargo não foi selecionado.");

    }else if(client.userName == null || client.userName!.isEmpty){
      alertSnackBar(context, "O nome de login está vazio.");

    }else if(client.password == null || client.password!.isEmpty){
      alertSnackBar(context, "A senha não esta vazia.");
    }
    else {
      // insertMealDatabase(meal);
      // Navigator.pop(context);
       "Receita salva com sucesso!";
    }
  }

  DateTime convertStringToDateTime(String date){

    String day = date.substring(0,2);
    String month = date.substring(3,5);
    String year = date.substring(6,10);
    
    return DateTime.parse("$year-$month-$day");
  }

  ScaffoldFeatureController alertSnackBar(BuildContext context, String message){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: appColors.red,));
  }

}