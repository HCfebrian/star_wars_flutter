import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

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
//  List<String> films;
//  List<String> species;
//  List<String> vehicles;
//  List<String> starships;
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
//      this.films,
//      this.species,
//      this.vehicles,
//      this.starships,
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
//    films = json['films'].cast<String>();
//    species = json['species'].cast<String>();
//    vehicles = json['vehicles'].cast<String>();
//    starships = json['starships'].cast<String>();
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  static Future<List<Person>> getPersons() async {
    String apiURL = "https://swapi.co/api/people/";

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);

    List<dynamic> listPerson = (jsonObject as Map<String, dynamic>)['results'];

    List<Person> persons = [];
    for (int i = 0; i < listPerson.length; i++) {
      persons.add(Person.fromJson(listPerson[i]));
    }

    log("banyaknya getperson" + persons.length.toString());
    return persons;
  }

  Map<String, dynamic> toMaap() {
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
//    map['films'] = this.films;
//    map['species'] = this.species;
//    map['vehicles'] = this.vehicles;
//    map['starships'] = this.starships;
    map['created'] = this.created;
    map['edited'] = this.edited;
    map['url'] = this.url;
    return map;
  }
}
