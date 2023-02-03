class PublishingCompany{

  String? id;
  String? name;

  PublishingCompany({this.id ,this.name});

    factory PublishingCompany.fromMap(Map map) {
    return PublishingCompany(
      id: map['id'],
      name: map['name'],
    );
  }

}