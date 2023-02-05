import 'package:intl/intl.dart';

class Book{

  String? id;
  String? title;
  String? author;
  int? quantity;
  DateTime? releaseDate;
  String? publishingCompanyId;
 

  Book({this.id, this.title, this.author, this.quantity, this.releaseDate, this.publishingCompanyId});
  

  factory Book.fromMap(Map map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      quantity: map['quantity'],
      releaseDate: DateTime.parse(map["releaseDate"]),
    );
  }

  Map<String, dynamic> toMap() {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String releaseDateFormatted = formatter.format(releaseDate!);

    Map<String, dynamic> map = {
      'title': title,
      'author': author,
      'quantity': quantity,
      'releaseDate': releaseDateFormatted,
      'publishingCompanyId':publishingCompanyId
    };
    return map;
  }


}