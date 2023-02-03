class Rent{

  String? id;
  String? bookId;
  String? clientId;
  DateTime? loanDate;
  DateTime? returnDate;
  
  Rent({this.id, this.bookId, this.clientId, this.loanDate, this.returnDate});

  factory Rent.fromMap(Map map) {
    return Rent(
      id: map['id'],
      bookId: map['name'],
      clientId: map['email'],
      loanDate: DateTime.parse(map['birthDate']),
      returnDate: DateTime.parse(map["cpf"]),
    );
  }


}