import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:starwarsapplication/models/Persons.dart';
import 'package:starwarsapplication/resources/ApiProvider.dart';
import 'dart:async';

import 'DbHelper.dart';

class Repository{
  final apiProvider = ApiProvider();
  final dbHelper = DbHelper();
  
  Future<List<Person>> fetchAllPerson() =>
    apiProvider.getPersons();

  Future<List<Person>> getAllPerson() => dbHelper.getpersonList();
  
  Future<int> insetPerson(Person person) => dbHelper.insert(person);
  
  Future updatePerson(Person person) {
    log("ini bagian repo" + person.toJson().toString());
    dbHelper.update(person);
  }
  Future<int> deletePerson(String url) => dbHelper.delete(url);


}