class Book{

  String? id;
  String? title;
  String? author;
  int? quantity;
  DateTime? releaseDate;
 

  Book({this.id, this.title, this.author, this.quantity, this.releaseDate});
  

  factory Book.fromMap(Map map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      quantity: map['quantity'],
      releaseDate: DateTime.parse(map["releaseDate"]),
    );
  }


}