import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
import 'package:meedu/meedu.dart';
import 'package:meedu/src/state_managment/base_controller.dart';
import 'package:test/test.dart';

void main() {
  test('dart stream vs get_stream', () async {
    // await dartValueNotifier();
    // await getValue();
    await dartStream();
    // await getStream();
    await meedu();
  });
}

const times = 3000;

// Future<void> dartValueNotifier() {
//   Completer completer = Completer();
//   final value = ValueNotifier<int>(0);

//   DateTime startTime = DateTime.now(), endTime;
//   value.addListener(() {
//     if (times == value.value) {
//       endTime = DateTime.now();
//       final diff = endTime.difference(startTime).inMilliseconds;
//       print("""$times listeners notified | [VALUE_NOTIFIER] time: ${diff}ms""");

//       completer.complete();
//     }
//   });
//   for (var i = 1; i <= times; i++) {
//     value.value = i;
//   }
//   return completer.future;
// }

Future<void> dartStream() {
  Completer completer = Completer();
  final value = StreamController<int>();

  DateTime startTime = DateTime.now(), endTime;
  value.stream.listen((v) {
    if (times == v) {
      endTime = DateTime.now();
      final diff = endTime.difference(startTime).inMilliseconds;
      print("""$v listeners notified | [STREAM] time: ${diff}ms""");
      value.close();
      completer.complete();
    }
  });
  for (var i = 1; i <= times; i++) {
    value.add(i);
  }
  return completer.future;
}

// Future<void> getValue() {
//   Completer completer = Completer();
//   final value = Value<int>(0);

//   DateTime startTime = DateTime.now(), endTime;
//   value.addListener(() {
//     if (times == value.value) {
//       endTime = DateTime.now();
//       final diff = endTime.difference(startTime).inMilliseconds;
//       print("""$times listeners notified | [GET_VALUE_NOTIFIER] time: ${diff}ms""");
//       completer.complete();
//     }
//   });
//   for (var i = 1; i <= times; i++) {
//     value.value = i;
//   }
//   return completer.future;
// }

// Future<void> getStream() {
//   Completer completer = Completer();
//   final value = GetStream<int>();

//   DateTime startTime = DateTime.now(), endTime;
//   value.stream.listen((v) {
//     if (times == v) {
//       endTime = DateTime.now();
//       final diff = endTime.difference(startTime).inMilliseconds;
//       print("""$v listeners notified | [GET_STREAM] time: ${diff}ms""");
//       value.close();
//       completer.complete();
//     }
//   });
//   for (var i = 1; i <= times; i++) {
//     value.add(i);
//   }
//   return completer.future;
// }

Future<void> meedu() {
  Completer completer = Completer();
  final controller = MyController();

  DateTime startTime = DateTime.now(), endTime;
  controller.addListener(BaseListener<int>(
    (value) {
      if (times == value) {
        endTime = DateTime.now();
        final diff = endTime.difference(startTime).inMilliseconds;
        print("""$value listeners notified | [MEEDU STATE CONTROLLER] time: ${diff}ms""");
        completer.complete();
      }
    },
  ));

  for (var i = 1; i <= times; i++) {
    controller.notify(i);
  }
  return completer.future;
}

class MyController extends StateController<int> {
  MyController() : super(0);
}
