import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
class Person {

  String name;
  String height;

  Person(
  this.name,
  this.height,
  );

  Person.fromJson(Map<String, dynamic> json) {
  name = json['name'];
  height = json['height'];

  }

  static Future<List<Person>> getPersons() async {
    String apiURL = "https://swapi.co/api/people/";

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);

    List<dynamic> listPerson = (jsonObject as Map<String,dynamic>)['results'];

    List<Person> persons = [];
    for(int i =0; i<listPerson.length; i++){
      persons.add(Person.fromJson(listPerson[i]));
    }

    log("banyaknya getperson" + persons.length.toString());
    return persons;
  }

  Map<String, dynamic> toMaap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['name'] = name;
    map['height'] = height;
    return map;
  }



}

