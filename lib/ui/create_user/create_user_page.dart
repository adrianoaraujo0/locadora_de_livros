import 'package:flutter/material.dart';
import 'package:locadora_de_livros/ui/create_user/create_user_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class CreateUserPage extends StatelessWidget {
  CreateUserPage({super.key});

  CreateUserController createUserController = CreateUserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            formUser(),
            const SizedBox(height: 100),
            buttonCreateUser(),
          ],
        ),
      ),
    );
  }

  Widget formUser(){
    return Form(
      key: createUserController.formKey,
      child: Column(
        children: [
          textFieldForm("Nome do usuário", Icons.person,),
          const SizedBox(height: 20),
          textFieldForm("Cidade do usuário", Icons.location_city),
          const SizedBox(height: 20),
          textFieldForm("Endereço do usuário", Icons.home),
          const SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if(value != null && value.isEmpty){
                return "Preencha este campo";
              }else if(!value!.contains("@")){
                return "Email inválido.";
              }
            },
            decoration: const InputDecoration(hintText: "Email do usuário", suffixIcon: Icon(Icons.email))
          )
        ],
      ),
    );
  }

  Widget textFieldForm(String hintText, IconData icon){
    return TextFormField(
      onFieldSubmitted: (value) {
        createUserController.formKey.currentState!.validate();
        createUserController.myFocusNodes.nextFocus();
      },
      validator: (value) {
        if(value != null && value.isEmpty){
          return "Preencha este campo";
        }
        return null;
      },
      decoration: InputDecoration(hintText: hintText, suffixIcon: Icon(icon))
    );
  }

  Widget buttonCreateUser(){
    return InkWell(
      onTap: ()=> createUserController.formKey.currentState!.validate(),
      child: Container(
        height: 50,
        width: double.maxFinite * 0.8,
        decoration:  BoxDecoration(color: appColors.purple, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Cadastrar", style: TextStyle(color: appColors.white, fontSize: 20))),
      ),
    );
  }
}