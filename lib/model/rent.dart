import 'package:intl/intl.dart';

class Rent{

  String? id;
  String? bookId;
  String? clientId;
  DateTime? loanDate;
  DateTime? returnDate;
  String? nameClient;
  String? nameBook;
  String? rentStatus;

  Rent({this.id, this.bookId, this.clientId, this.loanDate, this.returnDate, this.nameClient, this.nameBook, this.rentStatus});

  factory Rent.fromMap(Map map) {
    return Rent(
      id: map['id'],
      bookId: map['bookId'],
      clientId: map['clientId'],
      returnDate: DateTime.parse(map["returnDate"]),
      nameClient: map['client']['name'],
      nameBook: map['book']['title'],
      rentStatus: map['rentStatus']
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'bookId': bookId,
      'clientId': clientId,
      'returnDate': convertDateToString(returnDate!),
      'loanDate': convertDateToString(loanDate!),
    };
    return map;
  }

  String convertDateToString(DateTime dateTime){

    String day = dateTime.day.toString();
    String month = dateTime.month.toString();
    String year = dateTime.year.toString();
    return "$year-${month.padLeft(2, "0")}-${day.padLeft(2, "0")}";
  }

  @override
  String toString() {
    // TODO: implement toString
    return "bookId: $bookId, clientId: $clientId, returnDate: $returnDate, loanDate: $loanDate";
  }


}