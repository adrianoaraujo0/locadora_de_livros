import 'package:flutter/material.dart';
import 'package:locadora_de_livros/ui/menu/menu_page.dart';
import 'package:rxdart/rxdart.dart';

class LoginController{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  BehaviorSubject<bool> streamObscurePassword = BehaviorSubject<bool>(); 

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void validationForm(BuildContext context){
    if(emailController.text.isEmpty || !emailController.text.contains("@") || !emailController.text.contains(".com")){
      formKey.currentState!.validate();
    }else if(passwordController.text.isEmpty){
      formKey.currentState!.validate();
    }else if(emailController.text == "adr@a.com" && passwordController.text == "123456"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MenuPage()));
    }
  }
  
}