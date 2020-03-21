import 'package:sqflite/sqflite.dart';
import 'dart:async';

//mendukug pemrograman asinkron
import 'dart:io';

//bekerja pada file dan directory
import 'package:path_provider/path_provider.dart';
import 'package:starwarsapplication/main.dart';

import 'model/Person.dart';

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
    String path = directory.path + 'person.db';
    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama person
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE person (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        height TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

//  Future<bool> isFirst() async {
//    Database db = await this.database;
//    bool mapList = await db.query(firstInit);
//    return mapList;
//  }

  Future<List<Map<String, dynamic>>> selectascd() async {
    Database db = await this.database;
    var mapList = await db.query('person', orderBy: 'name');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectdscd() async {
    Database db = await this.database;
    var mapList = await db.query('person', orderBy: 'name' );
    return mapList;
  }

//create databases
  Future<int> insert(Person object) async {
    Database db = await this.database;
    int count = await db.insert('person', object.toMaap());
    return count;
  }

//update databases
  Future<int> update(Person object) async {
    Database db = await this.database;
    int count = await db.update('person', object.toMaap(),
        where: 'name=?', whereArgs: [object.name]);
    return count;
  }

//delete databases
  Future<int> delete(String name) async {
    Database db = await this.database;
    int count = await db.delete('person', where: 'name=?', whereArgs: [name]);
    return count;
  }

  Future<List<Person>> getpersonList() async {
    var personMapList = await selectascd();
    int count = personMapList.length;
    List<Person> personList = List<Person>();
    for (int i = 0; i < count; i++) {
      personList.add(Person.fromJson(personMapList[i]));
    }
    return personList;
  }
}
