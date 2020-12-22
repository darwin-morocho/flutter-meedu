import 'package:meedu/get.dart';
import 'package:test/test.dart';

void main() {
  group('dependecy injection', () {
    test('put', () {
      Person c1;
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
      Person t1;
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
      Person c1;
      try {
        c1 = Get.i.lazyFind<Person>();
      } catch (e) {}
      expect(c1, isNull);
      Get.i.lazyPut<Person>(() => Person());
      c1 = Get.i.lazyFind<Person>();
      final c2 = Get.i.lazyFind<Person>();
      expect(c1, isNotNull);
      expect(c2, isNotNull);
      expect(c1.hashCode == c2.hashCode, false);

      Person t1;
      try {
        t1 = Get.i.lazyFind<Person>(tag: 't');
      } catch (e) {}
      expect(t1, isNull);
      Get.i.lazyPut<Person>(() => Person(), tag: 't');
      t1 = Get.i.lazyFind<Person>(tag: 't');
      final t2 = Get.i.lazyFind<Person>(tag: 't');
      expect(t1, isNotNull);
      expect(t2, isNotNull);
      expect(t1.hashCode == t2.hashCode, false);
      Get.i.lazyRemove<Person>();
      Get.i.lazyRemove<Person>(tag: 't');
      try {
        c1 = Get.i.lazyFind<Person>();
        t1 = Get.i.lazyFind<Person>(tag: 't');
      } catch (e) {
        c1 = null;
        t1 = null;
      }
      expect(c1, isNull);
      expect(t1, isNull);
    });
  });
}

class Person {}
