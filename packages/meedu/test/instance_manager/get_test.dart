import 'dart:async';

import 'package:meedu/get.dart';
import 'package:test/test.dart';

final TypeMatcher<AssertionError> isAssertionError = isA<AssertionError>();
final Matcher throwsAssertionError = throwsA(isAssertionError);

void main() {
  setUp(() {
    Get.clear();
  });
  group('dependecy injection', () {
    test('has', () {
      final has = Get.has<Person>();
      expect(has, false);
      Get.put<Person>(Person());
    });
    test('put', () {
      Person? c1;
      try {
        c1 = Get.find<Person>();
        // ignore: empty_catches
      } catch (e) {}
      expect(c1, isNull);
      Get.put<Person>(Person());
      c1 = Get.find<Person>();
      final c2 = Get.find<Person>();
      expect(c1, isNotNull);
      // check that c1 and c2 are the same instance
      expect(c1.hashCode == c2.hashCode, true);

      // check with TAG
      Person? t1;
      try {
        t1 = Get.find<Person>(tag: 't');
        // ignore: empty_catches
      } catch (e) {}
      expect(t1, isNull);
      Get.put<Person>(Person(), tag: 't');
      t1 = Get.find<Person>(tag: 't');
      expect(t1, isNotNull);
      final t2 = Get.find<Person>(tag: 't');
      // check that t1 and t2 are the same instance
      expect(t1.hashCode == t2.hashCode, true);
      Get.remove<Person>();
      Get.remove<Person>(tag: 't');
      try {
        c1 = Get.find<Person>();
        t1 = Get.find<Person>(tag: 't');
      } catch (e) {
        c1 = null;
        t1 = null;
      }
      expect(c1, isNull);
      expect(t1, isNull);
    });
    test('lazy put', () {
      Person? c1;
      try {
        c1 = Get.find()<Person>();
        // ignore: empty_catches
      } catch (e) {}
      expect(c1, isNull);
      Get.lazyPut<Person>(() => Person());
      c1 = Get.find<Person>();
      final c2 = Get.find<Person>();
      expect(c1, isNotNull);
      expect(c2, isNotNull);
      expect(c1.hashCode == c2.hashCode, true);

      Person? t1;
      try {
        t1 = Get.find<Person>(
          tag: 't',
        );
        // ignore: empty_catches
      } catch (e) {}
      expect(t1, isNull);
      Get.lazyPut<Person>(() => Person(), tag: 't');
      t1 = Get.find<Person>(
        tag: 't',
      );
      final t2 = Get.find<Person>(
        tag: 't',
      );
      expect(t1, isNotNull);
      expect(t2, isNotNull);
      expect(t1.hashCode == t2.hashCode, true);
      Get.remove<Person>();
      Get.remove<Person>(tag: 't');
      Get.lazyRemove<Person>();
      Get.lazyRemove<Person>(tag: 't');

      expect(() => Get.find<Person>(), throwsAssertionError);
      expect(() => Get.find<Person>(tag: 't'), throwsAssertionError);
    });

    test('factory put', () {
      Get.factoryPut<Person>(
        (arguments) => Person(arguments as String? ?? ''),
      );
      final p1 = Get.factoryFind<Person>(arguments: 'Darwin');
      final p2 = Get.factoryFind<Person>(arguments: 'Santiago');
      expect(p1.name, 'Darwin');
      expect(p2.name, 'Santiago');
      expect(p1.hashCode != p2.hashCode, true);
    });

    test('async put', () async {
      Get.asyncPut<Person>(
        (arguments) async {
          await Future.delayed(
            const Duration(milliseconds: 10),
          );
          return Person(arguments as String? ?? '');
        },
      );
      Get.asyncPut<Person>((_) async {
        await Future.delayed(
          const Duration(milliseconds: 10),
        );
        return Person('');
      }, tag: 'tag');
      final p1 = await Get.asyncFind<Person>(arguments: 'Darwin');
      final p2 = await Get.asyncFind<Person>(arguments: 'Santiago');
      final p3 = await Get.asyncFind<Person>(tag: 'tag');
      expect(p1.name, 'Darwin');
      expect(p2.name, 'Santiago');
      expect(p3.name, '');
      expect(p1.hashCode != p2.hashCode, true);
      expect(() => Get.asyncFind<Person>(tag: 'random'), throwsAssertionError);
    });

    test('factory put without arguments', () {
      expect(() => Get.factoryFind<Person>(), throwsAssertionError);
      Get.factoryPut<Person>((_) => Person());
      final p1 = Get.factoryFind<Person>();
      final p2 = Get.factoryFind<Person>();
      expect(p1.name, '');
      expect(p2.name, '');
      expect(p1.hashCode != p2.hashCode, true);
    });

    test(
      'test onRemove',
      () async {
        Person? p;
        final completer = Completer();
        Get.put<Person>(
          Person('darwin'),
          onRemove: (person) {
            p = person;
            completer.complete();
          },
        );
        expect(Get.dependencies.isNotEmpty, true);
        Get.remove<Person>();
        await completer.future;
        expect(p != null, true);
      },
    );

    test(
      'test onRemove with lazy',
      () async {
        Person? p;
        final completer = Completer();
        Get.lazyPut<Person>(
          () => Person('darwin'),
          onRemove: (person) {
            p = person;
            completer.complete();
          },
        );
        Get.find<Person>();
        expect(Get.dependencies.isNotEmpty, true);
        Get.remove<Person>();
        await completer.future;
        expect(p != null, true);
      },
    );
  });
}

class Person {
  final String name;
  Person([this.name = '']) {
    print('Person $hashCode');
  }
}
