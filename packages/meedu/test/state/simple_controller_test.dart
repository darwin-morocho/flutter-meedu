import 'dart:async';

import 'package:meedu/meedu.dart';
import 'package:test/test.dart';

// ignore: unused_element
typedef _Subscriber = void Function(List<String>);
void main() {
  test('SimpleController', () async {
    const times = 50;
    final completer = Completer();
    final c = Controller();
    var value = c.counter;
    expect(value, 0);
    expect(c.hasListeners, false);
    final subscribe = (_) {
      value = c.counter;
      if (value == times) {
        completer.complete();
      }
    };
    c.addListener(subscribe);
    expect(c.hasListeners, true);
    for (var i = 1; i <= times; i++) {
      c.counter = i;
      c.notify();
    }
    await completer.future;
    expect(value, times);
    c.removeListener(subscribe);
    c.dispose();
    expect(c.disposed, true);
    expect(() {
      c.notify();
    }, throwsA(isA<AssertionError>()));
  });
}

class Controller extends SimpleNotifier {
  int counter = 0;
}
