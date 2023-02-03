class Client{
  
  String? id;
  String? name;
  String? email;
  DateTime? birthDate;
  String? cpf;
  String? position;
  String? profilePicture;
  String? userName;
  String? password;

  Client({this.id ,this.name, this.email, this. birthDate, this.cpf, this.position, this.profilePicture, this.userName, this.password});


 factory Client.fromMap(Map map) {
    return Client(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      birthDate: map['birthDate'],
      cpf:map["cpf"],
      position: map['position'],
      profilePicture: map['profilePicture'],
      userName: map['userCreateRequest.password'],
      password: map['userCreateRequest.username'],
    );
  }


  @override
  String toString() {
    // TODO: implement toString
    return "name: $name, email: $email, birthDate: $birthDate, cpf: $cpf, position: $position, img: $profilePicture, username: $userName, password: $password";
  }

}