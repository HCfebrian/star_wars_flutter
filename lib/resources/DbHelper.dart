import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Persons.dart';

//pubspec.yml
//kelass Dbhelper
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
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'starwardb.db';
    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama person
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


  Future<List<Map<String, dynamic>>> selectascd() async {
    Database db = await this.database;
    var mapList = await db.query('person', orderBy: 'name');
    return mapList;
  }

//create databases
  Future<int> insert(Person object) async {
    Database db = await this.database;
    int count = await db.insert('person', object.toJson());
    return count;
  }
//

//update databases
  Future<int> update(Person object) async {
    log("ini nilai person didalam db helper " + object.toJson().toString());
    Database db = await this.database;
    int count = await db.update('person', object.toJson(),
        where: 'url=?', whereArgs: [object.url]);
    return count;
  }

//delete databases
  Future<int> delete(String url) async {
    Database db = await this.database;
    int count = await db.delete('person', where: 'url=?', whereArgs: [url]);
    return count;
  }

  Future<List<Person>> getpersonList() async {
    var personMapList = await selectascd();
    int count = personMapList.length;
    List<Person> personList = List<Person>();
    for (int i = 0; i < count; i++) {
      personList.add(Person.fromJson(personMapList[i]));
    }
    log(personList[0].name);
    return personList;
  }
}
