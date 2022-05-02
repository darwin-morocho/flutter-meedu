import 'dart:async';

import 'package:example/app/ui/pages/counter/controller/counter_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'CounterController',
    () async {
      final controller = CounterController();
      final completer = Completer();
      controller.addListener(
        (_) {
          completer.complete();
        },
      );
      expect(controller.counter, 0);
      controller.increment();
      await completer.future;
      expect(controller.counter, 1);
    },
  );
}
