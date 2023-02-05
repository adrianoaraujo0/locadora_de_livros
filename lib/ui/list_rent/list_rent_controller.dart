
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

  String convertDateTimeToString(DateTime date){
    
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();
    
    return "${day.padLeft(2,"0")}/${month.padLeft(2,"0")}/${year.padLeft(2,"0")}";
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

  Future<void> putRent(String id) async{
    await rentService.putBook(id);
    await initListRentPage();
  }

   void search(String value){
    List<Rent> listFilter = rents.where((element) => element.nameClient!.toUpperCase().contains(value.toUpperCase())).toList();
    streamRents.sink.add(listFilter);
  }

}