import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'DbHelper.dart';
import 'enttryform.dart';
import 'model/Person.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //judul
      debugShowCheckedModeBanner: false,
      title: 'Tambahkan Daftar',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Person> listPerson;
  int count = 0;
  bool asce = true;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    log("boool " + _seen.toString());

    if (_seen) {
      updateListView();
      log("bukaan");
    } else {
      try {
        Person.getPersons().then((persons) {
          setState(() {
            for (int i = 0; i < persons.length; i++) {
              addContact(persons[i]);
            }
            log("nilai count adalah dalam getperson " + count.toString());
            log("get mass " + persons[1].mass);
          });
        });
        await prefs.setBool('seen', true);
      } catch (e) {
        log("something went wrong " + e.toString());
      }
    }
  }

  void initState() {
    super.initState();
    log("jalan njir");
    checkFirstSeen();
  }

  DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    if (listPerson == null) {
      listPerson = List<Person>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars '),
//        leading: Icon(
//          Icons.cached,
//        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  asce = !asce;
                  updateListView();
                  log(listPerson[1].name);
                },
                child: Icon(
                  Icons.cached,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: createListView(false),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          if (contact != null) addContact(contact);
        },
      ),
    );
  }

  Future<Person> navigateToEntryForm(
      BuildContext context, Person person) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(person);
    }));
    return result;
  }

  ListView createListView(bool dscd) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      reverse: dscd,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Text(
              this.listPerson[index].name,
              style: textStyle,
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
              _showDialog(listPerson[index]);
              },
            ),
            onTap: () async {
              var contact =
                  await navigateToEntryForm(context, this.listPerson[index]);
              if (contact != null) editContact(contact);
            },
          ),
        );
      },
    );
  }

  //buat contact
  void addContact(Person object) async {
    log(object.toMaap().toString());
    int result = await dbHelper.insert(object);
    updateListView();
    if (result > 0) {
      updateListView();
    }
  }

  //edit contact
  void editContact(Person object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  //delete contact
  void deleteContact(Person object) async {
    var result = await dbHelper.delete(object.name);
    if (result > 0) {
      updateListView();
    }
  }

  //update contact
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Person>> listPersonFuture = dbHelper.getpersonList();
      listPersonFuture.then((listPerson) {
        setState(() {
          if (asce == true) {
            this.listPerson = listPerson;
          } else {
            this.listPerson = listPerson.reversed.toList();
          }
          this.count = listPerson.length;
        });
      });
    });
  }

  // user defined function
  void _showDialog(Person object) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delate " + object.name),
          content: new Text("Are You Sure?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            RaisedButton(
              child: new Text("Yes"),
              onPressed: () {
                log("delete dong");
                deleteContact(object);
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            RaisedButton(
              child: new Text("NO"),
              color: Colors.blue,
              onPressed: () {
                log("cancel dong");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
