import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Persons.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'strwr.db';
    var db = openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE person (
        name TEXT,
        height TEXT,
        mass TEXT,
        hair_color TEXT,
        skin_color TEXT,
        eye_color TEXT,
        birth_year TEXT,
        gender TEXT,
        homeworld TEXT,
        created TEXT,
        edited TEXT,
        url TEXT PRIMARY KEY
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('person', orderBy: 'name');
    return mapList;
  }

  Future insert(Person object) async {
    Database db = await this.database;
    db.insert('person', object.toJson());
  }

//update databases
  Future update(Person object) async {
    Database db = await this.database;
    db.update('person', object.toJson(),
        where: 'url=?', whereArgs: [object.url]);
  }

//delete databases
  Future delete(String url) async {
    Database db = await this.database;
    db.delete('person', where: 'url=?', whereArgs: [url]);
  }

  Future<List<Person>> getPersonList() async {
    var personMapList = await select();
    int count = personMapList.length;
    List<Person> personList = List<Person>();
    for (int i = 0; i < count; i++) {
      personList.add(Person.fromJson(personMapList[i]));
    }
    return personList;
  }
}
