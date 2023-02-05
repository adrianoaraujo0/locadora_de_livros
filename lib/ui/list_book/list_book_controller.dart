import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/service/books_service.dart';
import 'package:rxdart/rxdart.dart';

class ListBooksController{
  
  BooksService booksService = BooksService();

  BehaviorSubject<List<Book>> streamBook = BehaviorSubject<List<Book>>();

  List<Book> books = [];

  Future<void> initListBookPage() async{
    books = await booksService.getBooks();
    streamBook.sink.add(books);
  }

   void search(String value){
    List<Book> listFilter = books.where((element) => element.title!.toUpperCase().contains(value.toUpperCase())).toList();
    streamBook.sink.add(listFilter);
  }

}