
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'package:starwarsapplication/models/Persons.dart';

class ApiProvider{
  final String apiURL = "https://swapi.co/api/people/";


  Future<List<Person>> getPersons() async {

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);

//    var jsonbody = Persons.fromJson(jsonObject);
//    log("ini loh orang orangnya" + jsonbody.toJson().toString());
//
    List<dynamic> listPerson = (jsonObject as Map<String, dynamic>)['results'];

    List<Person> persons = [];
    for (int i = 0; i < listPerson.length; i++) {
      persons.add(Person.fromJson(listPerson[i]));
    }

//    log("banyaknya getperson" + persons.length.toString());
    return persons;
  }

}