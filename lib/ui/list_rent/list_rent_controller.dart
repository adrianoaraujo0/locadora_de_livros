
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
    rents = await rentService.getRents();
    streamRents.sink.add(rents);
  }

  //  void search(String value){
  //   List<Rent> listFilter = rents.where((element) => element.loanDate!.toUpperCase().contains(value.toUpperCase())).toList();
  //   streamRents.sink.add(listFilter);
  // }

}