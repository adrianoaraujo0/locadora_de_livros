import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

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
      userName: map['userCreateRequest.userName'],
      password: map['userCreateRequest.password'],
    );
  }

  Future<FormData> toPostFormData()async {
    String fileName = profilePicture!.split('/').last;

    FormData data = FormData.fromMap({
      'name': name,
      'email': email,
      'birthDate': convertDateTimeToString(birthDate!),
      'cpf': cpf,
      'position': position,
      'profilePicture': await MultipartFile.fromFile( profilePicture!, filename: fileName, contentType:  MediaType("image", "jpeg")),
      'userCreateRequest.password': password,
      'userCreateRequest.username': userName,
    });
    return data;
  }

   Future<FormData> toPutFormData()async {
    // String fileName = profilePicture!.split('/').last;

    FormData data = FormData.fromMap({
      'id': id,
      'name': name,
      'email': email,
      'birthDate': convertDateTimeToString(birthDate!),
      'cpf': cpf,
      'position': position,
      // 'profilePicture': await MultipartFile.fromFile( profilePicture!, filename: fileName, contentType:  MediaType("image", "jpeg")),
      'userCreateRequest.password': password,
      'userCreateRequest.username': userName,
    });
    return data;
  }


  String convertDateTimeToString(DateTime date){
    
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();
    
    return "$year-${month.padLeft(2,"0")}-${day.padLeft(2,"0")}";
  }


  @override
  String toString() {
    // TODO: implement toString
    return "id: $id ,name: $name, email: $email, birthDate: $birthDate, cpf: $cpf, position: $position, img: $profilePicture, username: $userName, password: $password";
  }

}