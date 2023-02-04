import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:locadora_de_livros/service/books_service.dart';
import 'package:locadora_de_livros/service/publishing_companies_service.dart';
import 'package:locadora_de_livros/ui/list_book/list_book_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rxdart/rxdart.dart';

class UpdateBookController{


  BehaviorSubject<Book> streamForm = BehaviorSubject<Book>();
  BehaviorSubject<String> streamPopMenuButton = BehaviorSubject<String>();

  BooksService booksService = BooksService();

  MaskTextInputFormatter releaseDateMask = MaskTextInputFormatter(mask: '##/##/####');
  MaskTextInputFormatter quantityMask = MaskTextInputFormatter(mask: '#####');

  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();


  List<PublishingCompany>  publishingCompanies = [];

  Future<void> initPopButton() async{
  }

  void initUpdatePage(Book book){
    titleController.text = book.title!;
    authorController.text = book.author!;
    dateController.text = convertDateTimeToString(book.releaseDate!);
    quantityController.text = book.quantity.toString();
    streamForm.sink.add(book);
  }
  

   void validationForm(Book book, BuildContext context){
    log("${book.quantity}");
    if(book.title == null || book.title!.isEmpty){
      alertSnackBar(context, "O título do livro está vazio.");

    }else if(book.author == null || book.author!.isEmpty){
      alertSnackBar(context, "O nome do author vazio.");

    }else if(book.releaseDate == null){
      alertSnackBar(context, "A data de lançamento está incorreta.");

    }else if(book.releaseDate!.isAfter(DateTime.now())){
      alertSnackBar(context, "A data de lançamento não pode ser depois da data atual.");

    }else if(book.quantity == null){
      alertSnackBar(context, "A quantidade está vazia.");

    }else if(book.quantity == 0){
      alertSnackBar(context, "A quantidade não pode ser 0.");
    }
    else if(book.publishingCompanyId == null){
      alertSnackBar(context, "Escolha uma editora.");
    }
    else {
      // saveBook(book);
      alertSnackBar(context, "Livro cadastrado com sucesso!", color: appColors.green);
    }
  }



  DateTime convertStringToDateTime(String date){

    String day = date.substring(0,2);
    String month = date.substring(3,5);
    String year = date.substring(6,10);
    
    return DateTime.parse("$year-$month-$day");
  }

    String convertDateTimeToString(DateTime date){
    
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();
    
    return "${day.padLeft(2,"0")}/${month.padLeft(2,"0")}/${year.padLeft(2,"0")}";
  }

  ScaffoldFeatureController alertSnackBar(BuildContext context, String message, {Color? color}){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color??appColors.red));
  }

  Future<void> saveBook(Book book) async => await booksService.postBook(book);

 

}

