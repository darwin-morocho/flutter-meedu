import 'package:meedu/get.dart';
import 'package:test/test.dart';

final TypeMatcher<AssertionError> isAssertionError = isA<AssertionError>();
final Matcher throwsAssertionError = throwsA(isAssertionError);

void main() {
  setUp(() {
    Get.i.clear();
  });
  group('dependecy injection', () {
    test('has', () {
      final has = Get.i.has<Person>();
      expect(has, false);
    });
    test('put', () {
      Person? c1;
      try {
        c1 = Get.i.find<Person>();
      } catch (e) {}
      expect(c1, isNull);
      Get.i.put<Person>(Person());
      c1 = Get.i.find<Person>();
      final c2 = Get.i.find<Person>();
      expect(c1, isNotNull);
      // check that c1 and c2 are the same instance
      expect(c1.hashCode == c2.hashCode, true);

      // check with TAG
      Person? t1;
      try {
        t1 = Get.i.find<Person>(tag: 't');
      } catch (e) {}
      expect(t1, isNull);
      Get.i.put<Person>(Person(), tag: 't');
      t1 = Get.i.find<Person>(tag: 't');
      expect(t1, isNotNull);
      final t2 = Get.i.find<Person>(tag: 't');
      // check that t1 and t2 are the same instance
      expect(t1.hashCode == t2.hashCode, true);
      Get.i.remove<Person>();
      Get.i.remove<Person>(tag: 't');
      try {
        c1 = Get.i.find<Person>();
        t1 = Get.i.find<Person>(tag: 't');
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
        c1 = Get.i.find()<Person>();
      } catch (e) {}
      expect(c1, isNull);
      Get.i.lazyPut<Person>(() => Person());
      c1 = Get.i.find<Person>();
      final c2 = Get.i.find<Person>();
      expect(c1, isNotNull);
      expect(c2, isNotNull);
      expect(c1.hashCode == c2.hashCode, true);

      Person? t1;
      try {
        t1 = Get.i.find<Person>(
          tag: 't',
        );
      } catch (e) {}
      expect(t1, isNull);
      Get.i.lazyPut<Person>(() => Person(), tag: 't');
      t1 = Get.i.find<Person>(
        tag: 't',
      );
      final t2 = Get.i.find<Person>(
        tag: 't',
      );
      expect(t1, isNotNull);
      expect(t2, isNotNull);
      expect(t1.hashCode == t2.hashCode, true);
      Get.i.remove<Person>();
      Get.i.remove<Person>(tag: 't');
      Get.i.lazyRemove<Person>();
      Get.i.lazyRemove<Person>(tag: 't');

      expect(() => Get.i.find<Person>(), throwsAssertionError);
      expect(() => Get.i.find<Person>(tag: 't'), throwsAssertionError);
    });

    test('factory put', () {
      Get.i.factoryPut<Person, String>((arguments) => Person(arguments ?? ""));
      final p1 = Get.i.factoryFind<Person, String>(arguments: "Darwin");
      final p2 = Get.i.factoryFind<Person, String>(arguments: "Santiago");
      expect(p1.name, "Darwin");
      expect(p2.name, "Santiago");
      expect(p1.hashCode != p2.hashCode, true);
    });

    test('factory put without arguments', () {
      expect(() => Get.i.factoryFind<Person, void>(), throwsAssertionError);
      Get.i.factoryPut<Person, void>((_) => Person());
      final p1 = Get.i.factoryFind<Person, void>();
      final p2 = Get.i.factoryFind<Person, void>();
      expect(p1.name, "");
      expect(p2.name, "");
      expect(p1.hashCode != p2.hashCode, true);
    });
  });
}

class Person {
  final String name;
  Person([this.name = '']);
}
