
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/rent.dart';
import 'package:locadora_de_livros/service/books_service.dart';
import 'package:locadora_de_livros/service/rent_service.dart';
import 'package:rxdart/rxdart.dart';


class ListRentController{

  RentService rentService = RentService();

  BehaviorSubject<List<Rent>> streamRents = BehaviorSubject<List<Rent>>();

  List<Rent> rents = [];

  Future<void> initListRentPage() async{
    // rents = await rentService.getRents();
    rents = [Rent(bookId: "1", clientId: "", loanDate: DateTime.parse("2023-02-26"), returnDate: DateTime.parse("2023-03-23"))];
    streamRents.sink.add(rents);
  }

  String convertDateTimeToString(DateTime date){
    
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();
    
    return "${day.padLeft(2,"0")}/${month.padLeft(2,"0")}/${year.padLeft(2,"0")}";
  }

  //  void search(String value){
  //   List<Rent> listFilter = rents.where((element) => element.loanDate!.toUpperCase().contains(value.toUpperCase())).toList();
  //   streamRents.sink.add(listFilter);
  // }

}