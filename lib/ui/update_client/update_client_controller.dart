import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/service/client_service.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rxdart/subjects.dart';

class UpdateClientController{

  ClientService clientService = ClientService();

  BehaviorSubject<Client> streamForm = BehaviorSubject<Client>();
  BehaviorSubject<String> streamPopMenuButtonPosition = BehaviorSubject<String>();
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

  Future<void> initUpdatePage(String id) async{
    Client client = await clientService.getClientById(id);
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaa: ${client.toString()}");

    nameController.text = client.name!;
    emailController.text = client.email!;
    cpfController.text = client.cpf!;
    birthDateController.text = convertDateTimeToString(client.birthDate!);
    usernameController.text = client.userName!;
    streamPopMenuButtonPosition.sink.add(client.position! == "PEOPLE" ? "Cliente" : "Admin");
    streamForm.sink.add(client);
  }

  void validationForm(Client client, BuildContext context){
    print(client.toString());
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

    }else if(client.password == null || client.password!.isEmpty || client.password!.length < 6){
      alertSnackBar(context, "A senha está inválida.");
    }
    else {
      updateClient(client);
      // insertMealDatabase(meal);
      // Navigator.pop(context);
    }
  }

    String convertDateTimeToString(DateTime date){
    
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();
    
    return "$year-${month.padLeft(2,"0")}-${day.padLeft(2,"0")}";
  }

  Future<void> updateClient(Client client) async => clientService.putClient(client);

  ScaffoldFeatureController alertSnackBar(BuildContext context, String message){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: appColors.red));
  }

}

