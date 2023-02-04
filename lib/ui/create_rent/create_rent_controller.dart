
import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:locadora_de_livros/model/rent.dart';
import 'package:locadora_de_livros/service/books_service.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rxdart/rxdart.dart';

class CreateRentController{


  BehaviorSubject<Rent> streamForm = BehaviorSubject<Rent>();
  BehaviorSubject<String> streamPopMenuButton = BehaviorSubject<String>();



  List<PublishingCompany>  publishingCompanies = [];

  Future<void> initPopButton() async{
  }



   void validationForm(BuildContext context ,Rent rent){
    if(rent.clientId == null || rent.clientId!.isEmpty){
      alertSnackBar(context, "Escolha o usuário.");

    }else if(rent.bookId  == null || rent.bookId!.isEmpty){
      alertSnackBar(context, "Escolha o livro.");

    }else if(rent.loanDate == null){
      alertSnackBar(context, "Escolha a data de retirada.");

    }else if(rent.returnDate == null){
      alertSnackBar(context, "Escolha a data de devolução.");

    }else {
      alertSnackBar(context, "Aluguel cadastrado com sucesso!", color: appColors.green);
    }
  }



  DateTime convertStringToDateTime(String date){

    String day = date.substring(0,2);
    String month = date.substring(3,5);
    String year = date.substring(6,10);
    
    return DateTime.parse("$year-$month-$day");
  }

  ScaffoldFeatureController alertSnackBar(BuildContext context, String message, {Color? color}){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color??appColors.red));
  }

  // Future<void> saveBook(Book book) async => await booksService.postBook(book);

 
 Future<void> pickLoanDate(BuildContext context, Rent rent) async{
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2023),
    lastDate: DateTime.now()
  );
  
    if(pickedDate != null){
      rent.loanDate = pickedDate;
      streamForm.sink.add(rent);
    }
  }

  Future<void> pickReturnDate(BuildContext context, Rent rent) async{
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100)
    );
  
    if(pickedDate != null){
      rent.returnDate = pickedDate;
      streamForm.sink.add(rent);
    }
  }

  String convertDateToString(DateTime dateTime){

    String day = dateTime.day.toString();
    String month = dateTime.month.toString();
    String year = dateTime.year.toString();

    return "${day.padLeft(2, "0")}/${month.padLeft(2, "0")}/$year";

  }

}

