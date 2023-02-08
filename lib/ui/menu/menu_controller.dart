import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/model/graphicBooks.dart';
import 'package:locadora_de_livros/model/menu.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:locadora_de_livros/model/rent.dart';
import 'package:locadora_de_livros/service/books_service.dart';
import 'package:locadora_de_livros/service/client_service.dart';
import 'package:locadora_de_livros/service/publishing_companies_service.dart';
import 'package:locadora_de_livros/service/rent_service.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';
import 'package:rxdart/rxdart.dart';

class MenuController{

  BehaviorSubject<Menu> streamMenuController = BehaviorSubject<Menu>();
  BehaviorSubject<List<GraphicBooks>> streamGraphicBooks = BehaviorSubject<List<GraphicBooks>>();
   BehaviorSubject<List<Rent>> streamRents = BehaviorSubject<List<Rent>>();

  List<Color> colorsDashBoard = [appColors.green, appColors.yellow, appColors.grey, appColors.red, appColors.purpleDark, appColors.blue];

  ClientService clientService = ClientService();
  RentService rentService = RentService();
  BooksService booksService = BooksService();
  PublishingCompaniesService publishingCompaniesService = PublishingCompaniesService();
  Menu menu = Menu();

  List<Rent> rents = [];

  Future<void> initMenu() async{
    await getQuantityBooks();
    await getQuantityRent();
    await getQuantityPublishingCompanies();
    await getQuantityClient();
     streamGraphicBooks.sink.add(
      [
        GraphicBooks("O contato", 5),
        GraphicBooks("Naruto HQ", 20),
        GraphicBooks("O sol é para todos", 50),
        GraphicBooks("On the road", 100),
        GraphicBooks("1984", 70),
        GraphicBooks("A revolução dos bichos", 40),
      ]
    );
    streamRents.sink.add(rents);
  }

  Future<void> getQuantityBooks() async{
    List<Book> books = await booksService.getBooks();
    menu.quantityBooks = books.length;
    streamMenuController.sink.add(menu);
  }

  Future<void> getQuantityPublishingCompanies() async{
    List<PublishingCompany> publishingCompanies = await publishingCompaniesService.getPublishingCompanies();
    menu.quantityPublishingCompanies = publishingCompanies.length;
    streamMenuController.sink.add(menu);
  }

  Future<void> getQuantityClient() async{
    List<Client> clients = await clientService.getClients();
    menu.quantityClients = clients.length;
    streamMenuController.sink.add(menu);
  }

  Future<void> getQuantityRent() async{
    rents = await rentService.getRents();
    menu.quantityRents = rents.length;
    streamMenuController.sink.add(menu);
  }

    String convertRentStatus(String rentStatus){
    if(rentStatus == "DELAY"){
      return "Atrasado";
    }if(rentStatus == "ONTIME"){
      return "Devolvido";
    }else{
      return "Em espera";
    }
  }


}