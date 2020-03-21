import 'package:flutter/material.dart';
import 'model/Person.dart';

class EntryForm extends StatefulWidget {
  final Person person;

  EntryForm(this.person);

  @override
  EntryFormState createState() => EntryFormState(this.person);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Person person;

  EntryFormState(this.person);

  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController massController = TextEditingController();
  TextEditingController hairColorController = TextEditingController();
  TextEditingController skinColorController = TextEditingController();
  TextEditingController eyeColorController = TextEditingController();
  TextEditingController birthYearController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController homeWorldController = TextEditingController();
  TextEditingController createdController = TextEditingController();
  TextEditingController editedController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (person != null) {
      nameController.text = person.name;
      heightController.text = person.height;
      massController.text = person.mass;
      hairColorController.text = person.hairColor;
      skinColorController.text = person.skinColor;
      eyeColorController.text = person.eyeColor;
      birthYearController.text = person.birthYear;
      genderController.text = person.gender;
      homeWorldController.text = person.homeworld;
      createdController.text = person.created;
      editedController.text = person.edited;
      urlController.text = person.url;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: person == null ? Text('Tambah') : Text('Rubah'),
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, person);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // tinggi
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: heightController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Height',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //mass
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: massController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Mass',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //haircolor
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: hairColorController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Hair Color',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //skinColor
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: skinColorController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Skin Color',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //eyeColor
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: eyeColorController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Eye Color',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //bearth year
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: birthYearController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Birth Color',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //GENDER
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: genderController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //homeworld
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: homeWorldController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'homeworld',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //created
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: createdController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'created',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //edited
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: editedController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'edited',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              //url
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: urlController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'url',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (person == null) {
                            // tambah data
                            person = Person(
                              nameController.text,
                              heightController.text,
                              massController.text,
                              hairColorController.text,
                              skinColorController.text,
                              eyeColorController.text,
                              birthYearController.text,
                              genderController.text,
                              homeWorldController.text,
                              createdController.text,
                              editedController.text,
                              urlController.text,
                            );
                          } else {
                            // ubah data
                            person.name = nameController.text;
                            person.height = heightController.text;
                            person.mass = massController.text;
                            person.hairColor = hairColorController.text;
                            person.skinColor = skinColorController.text;
                            person.eyeColor = eyeColorController.text;
                            person.birthYear = birthYearController.text;
                            person.gender = genderController.text;
                            person.homeworld = homeWorldController.text;
                            person.created = createdController.text;
                            person.edited = editedController.text;
                            person.url = urlController.text;

                          }
                          // kembali ke layar sebelumnya dengan membawa objek contact
                          Navigator.pop(context, person);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
