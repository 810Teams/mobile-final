///
/// `friend.dart`
/// Contains models from JSON 
///

class Friend {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  Friend.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.username = map['username'];
    this.email = map['email'];
    this.address = Address.fromMap(map['address']);
    this.phone = map['phone'];
    this.website = map['website'];
    this.company = Company.fromMap(map['company']);
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geolocation geo;

  Address.fromMap(Map<String, dynamic> map) {
    this.street = map['street'];
    this.suite = map['suite'];
    this.city = map['city'];
    this.zipcode = map['zipcode'];
    this.geo = Geolocation.fromMap(map['geo']);
  }
}

class Geolocation {
  String lat;
  String lon;

  Geolocation.fromMap(Map<String, dynamic> map) {
    this.lat = map['lat'];
    this.lon = map['lon'];
  }
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.catchPhrase = map['catchPhrase'];
    this.bs = map['bs'];
  }
}

class ToDo {
  int userId;
  int id;
  String title;
  bool completed;

  ToDo.fromMap(Map<String, dynamic> map) {
    this.userId = map['userId'];
    this.id = map['id'];
    this.title = map['title'];
    this.completed = map['completed'];
  }
}
