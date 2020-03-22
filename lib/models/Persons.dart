class Persons {
  int count;
  String next;
  Null previous;
  List<Person> persons;

  Persons({this.count, this.next, this.previous, this.persons});

  Persons.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      persons = new List<Person>();
      json['results'].forEach((v) {
        persons.add(new Person.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.persons != null) {
      data['results'] = this.persons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Person {
  String name;
  String height;
  String mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;
  String homeworld;
  String created;
  String edited;
  String url;

  Person(
      this.name,
      this.height,
      this.mass,
      this.hairColor,
      this.skinColor,
      this.eyeColor,
      this.birthYear,
      this.gender,
      this.homeworld,
      this.created,
      this.edited,
      this.url);

  Person.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    height = json['height'];
    mass = json['mass'];
    hairColor = json['hair_color'];
    skinColor = json['skin_color'];
    eyeColor = json['eye_color'];
    birthYear = json['birth_year'];
    gender = json['gender'];
    homeworld = json['homeworld'];
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['name'] = name;
    map['height'] = height;
    map['mass'] = this.mass;
    map['hair_color'] = this.hairColor;
    map['skin_color'] = this.skinColor;
    map['eye_color'] = this.eyeColor;
    map['birth_year'] = this.birthYear;
    map['gender'] = this.gender;
    map['homeworld'] = this.homeworld;
    map['created'] = this.created;
    map['edited'] = this.edited;
    map['url'] = this.url;
    return map;
  }
}
