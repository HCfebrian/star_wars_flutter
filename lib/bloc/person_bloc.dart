import 'package:rxdart/rxdart.dart';
import 'package:starwarsapplication/models/Persons.dart';
import 'package:starwarsapplication/resources/repository.dart';

class PersonBloc{
  Repository _repository = Repository();
  PublishSubject<List<Person>> _personFetcher = PublishSubject<List<Person>>();

  Observable<List<Person>> get allPerson => _personFetcher.stream;

  fetchAllPerson() async{
    List<Person> persons = await _repository.fetchAllPerson();
    for(int i =0; i < persons.length; i++){
      insetPerson(persons[i]);
      getAllPerson();
    }
  }

  getAllPerson() async{
    _personFetcher.sink.add(await _repository.dbHelper.getPersonList());
  }

  updatePerson(Person person) async{
    await _repository.updatePerson(person);
    getAllPerson();
  }

  insetPerson(Person person) async{
    await _repository.insetPerson(person);
    getAllPerson();
  }

  deletePerson(String url) async{
    await _repository.deletePerson(url);
    getAllPerson();
  }

  dispose(){
    _personFetcher.close();
  }
}

final bloc = PersonBloc();
