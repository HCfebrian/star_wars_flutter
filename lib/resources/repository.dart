import 'dart:async';

import 'package:starwarsapplication/models/Persons.dart';
import 'package:starwarsapplication/resources/ApiProvider.dart';

import 'DbHelper.dart';

class Repository {
  final apiProvider = ApiProvider();
  final dbHelper = DbHelper();

  Future<List<Person>> fetchAllPerson() => apiProvider.getPersons();

  Future<List<Person>> getAllPerson() => dbHelper.getPersonList();

  Future insetPerson(Person person) => dbHelper.insert(person);

  Future updatePerson(Person person) => dbHelper.update(person);

  Future deletePerson(String url) => dbHelper.delete(url);
}
