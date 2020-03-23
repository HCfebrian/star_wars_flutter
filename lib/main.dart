import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starwarsapplication/bloc/person_bloc.dart';

import 'models/Persons.dart';
import 'ui/enttryform.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //judul
      debugShowCheckedModeBanner: false,
      title: 'StarWars APP',
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

  bool descending = false;
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      bloc.getAllPerson();
    } else {
      try {
        bloc.fetchAllPerson();
        await prefs.setBool('seen', true);
      } catch (e) {
        log("something went wrong " + e.toString());
      }
    }
  }

  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars '),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  descending = !descending;
                  bloc.getAllPerson();
                },
                child: Icon(
                  Icons.cached,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.allPerson,
        builder: (context, AsyncSnapshot<List<Person>> snapshot) {
          if (snapshot.hasData) {

            return createListView(descending, snapshot);
          } else if (snapshot.hasError) {
            log("error");
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var person = await navigateToEntryForm(context, null);
          bloc.insetPerson(person);
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

  void _showDialog(Person object) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Delate " + object.name),
          content: new Text("Are You Sure?"),
          actions: <Widget>[
            RaisedButton(
              child: new Text("Yes"),
              onPressed: () {
                bloc.deletePerson(object.url);
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: new Text("NO"),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ListView createListView(bool dscd, AsyncSnapshot<List<Person>> snapshot) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.account_circle),
            ),
            title: Text(
              snapshot
                  .data[dscd ? (snapshot.data.length - 1) - index : index].name,
              style: textStyle,
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                _showDialog(snapshot.data[dscd?(snapshot.data.length - 1) - index: index]);
              },
            ),
            onTap: () async {
              Person person = await navigateToEntryForm(
                  context,
                  snapshot
                      .data[dscd ? (snapshot.data.length - 1) - index : index]);
              if (person != null) bloc.updatePerson(person);
              bloc.getAllPerson();
            },
          ),
        );
      },
    );
  }
}
