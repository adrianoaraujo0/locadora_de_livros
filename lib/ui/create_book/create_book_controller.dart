import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rxdart/rxdart.dart';

class CreateBookController{


  BehaviorSubject<Book> streamForm = BehaviorSubject<Book>();

  MaskTextInputFormatter releaseDateMask = MaskTextInputFormatter(mask: '##/##/####');
  MaskTextInputFormatter quantityMask = MaskTextInputFormatter(mask: '#####');

  TextEditingController nameController = TextEditingController();
  TextEditingController profilePictureController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  

   void validationForm(Book book, BuildContext context){
    log("${book.quantity}");
    if(book.title == null || book.title!.isEmpty){
      alertSnackBar(context, "O título do livro está vazio.");

    }else if(book.author == null || book.author!.isEmpty){
      alertSnackBar(context, "O nome do author vazio.");

    }else if(book.releaseDate == null){
      alertSnackBar(context, "A data de lançamento está incorreta.");

    }else if(book.quantity == null){
      alertSnackBar(context, "A quantidade está vazia.");
    }
    else {
      // insertMealDatabase(meal);
      // Navigator.pop(context);
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

