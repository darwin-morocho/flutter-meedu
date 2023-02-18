import 'dart:async';

import 'package:example/app/ui/pages/counter/bloc/counter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'CounterController',
    () async {
      final controller = CounterBloc(0);
      final completer = Completer();
      controller.addListener(
        (_) {
          completer.complete();
        },
      );
      expect(controller.state, 0);
      controller.add(Increment());
      await completer.future;
      expect(controller.state, 1);
    },
  );
}
