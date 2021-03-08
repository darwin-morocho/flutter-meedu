import 'dart:async';

import 'package:meedu/meedu.dart';
import 'package:test/test.dart';

const times = 50;
typedef _Subscriber = void Function(List<String>);
void main() {
  test('SimpleController', () async {
    final Completer completer = Completer();
    final c = Controller();
    int value = c.counter;
    expect(value, 0);
    c.onInit();
    c.onAfterFirstLayout();
    final _Subscriber subscribe = (List<String> listeners) {
      value = c.counter;
      if (value == times) {
        completer.complete();
      }
    };
    c.addListener(subscribe);
    for (int i = 1; i <= times; i++) {
      c.counter = i;
      c.update();
    }
    await completer.future;
    expect(value, times);
    c.removeListener(subscribe);
    c.onDispose();
    expect(c.disposed, true);
    expect(() {
      c.update();
    }, throwsA(isA<AssertionError>()));
  });
}

class Controller extends SimpleController {
  int counter = 0;

  @override
  void onInit() {
    super.onInit();
    print("😜 onInit");
  }

  @override
  void onAfterFirstLayout() {
    super.onAfterFirstLayout();
    print("😜 afterFirstLayout");
  }

  @override
  void onDispose() {
    print("😜 onDispose");
    super.onDispose();
  }
}
