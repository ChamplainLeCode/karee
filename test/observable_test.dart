import 'package:flutter_test/flutter_test.dart';
import 'package:karee/src/errors/exceptions/observable_error.dart';
import 'package:karee/src/observables/library.dart';

class Person {
  String? name;
  String? city;
  int? age;
  @override
  String toString() => 'Person [name=$name, city=$city, age=$age';
}

void main() {
  late Person person, person2, person3, person4;
  setUp(() {
    person = Person()
      ..age = 21
      ..city = 'Yaoundé'
      ..name = 'Champlain';
    person2 = Person()
      ..age = 22
      ..city = 'Marquise'
      ..name = 'Kapsiki';
    person3 = Person()
      ..age = 23
      ..city = 'Bakoko'
      ..name = 'Jane';
    person4 = Person()
      ..age = 24
      ..city = 'Douala'
      ..name = 'Marius';
  });
  group('Test of Observable -> ', () {
    test('Test set to cache / get from cache observable', () {
      var message = 'Hello World';
      const tag = #helloWorld;
      var ofName = Of.tag(message, tag);
      var ofNameRead = Of.withTag<String>(tag);
      expect(ofName, ofNameRead);
    });
    test('Read observable by Type from cache', () {
      var ofPerson = Of(person);
      PersistentContext.value(ofPerson);
      var ofPersonRead = Of<Person>.type();
      expect(ofPerson, ofPersonRead);
    });
    test('Test observable alert', () {
      var ofPerson = Of(person2);
      Person? person1;
      ofPerson.alert((p) => person1 = p);
      ofPerson.value = person3;
      ofPerson.value = person4;
      expect(person1!, person3);
    });
    test('Test observable Listener', () {
      var ofPerson = Of(person2);
      Person? person1;
      ofPerson.listen((p) => person1 = p);
      ofPerson.value = person3;
      expect(person1!, person3);
      ofPerson.value = person4;
      expect(person1!, person4);
    });
    test('Free observable from cache', () {
      var message = 'Hello World';
      const tag = #helloWorld;
      var ofName = Of.tag(message, tag);
      Of.free(ofName);

      /// We are trying to get removed observable by Tag
      expect(() => Of.withTag(tag),
          throwsA(isInstanceOf<NoObservableFoundWithTagError>()));
    });
  });
}
