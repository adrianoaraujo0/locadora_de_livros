import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/model/menu.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:locadora_de_livros/model/rent.dart';
import 'package:locadora_de_livros/service/books_service.dart';
import 'package:locadora_de_livros/service/client_service.dart';
import 'package:locadora_de_livros/service/publishing_companies_service.dart';
import 'package:locadora_de_livros/service/rent_service.dart';
import 'package:rxdart/rxdart.dart';

class MenuController{

  BehaviorSubject<Menu> streamMenuController = BehaviorSubject<Menu>();


  ClientService clientService = ClientService();
  RentService rentService = RentService();
  BooksService booksService = BooksService();
  PublishingCompaniesService publishingCompaniesService = PublishingCompaniesService();
  Menu menu = Menu();

  Future<void> initMenu() async{
    await getQuantityBooks();
    await getQuantityPublishingCompanies();
    await getQuantityClient();
    await getQuantityRent();
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
    List<Client> clients = await clientService.getClient();
    menu.quantityClients = clients.length;
    streamMenuController.sink.add(menu);
  }

  Future<void> getQuantityRent() async{
    List<Rent> rents = await rentService.getRent();
    menu.quantityRents = rents.length;
    streamMenuController.sink.add(menu);
  }



}