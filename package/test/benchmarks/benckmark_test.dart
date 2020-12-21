import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  test('dart stream vs get_stream', () async {
    await dartValueNotifier();
    await dartStream();
    await getStream();
  });
}

const times = 1000;

Future<void> dartValueNotifier() {
  Completer completer = Completer();
  final value = ValueNotifier<int>(0);

  DateTime startTime = DateTime.now(), endTime;
  value.addListener(() {
    if (times == value.value) {
      endTime = DateTime.now();
      final diff = endTime.difference(startTime).inMilliseconds;
      print("""$times listeners notified | [VALUE_NOTIFIER] time: ${diff}ms""");

      completer.complete();
    }
  });
  for (var i = 1; i <= times; i++) {
    value.value = i;
  }
  return completer.future;
}

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

Future<void> getStream() {
  Completer completer = Completer();
  final value = GetStream<int>();

  DateTime startTime = DateTime.now(), endTime;
  value.stream.listen((v) {
    if (times == v) {
      endTime = DateTime.now();
      final diff = endTime.difference(startTime).inMilliseconds;
      print("""$v listeners notified | [GET_STREAM] time: ${diff}ms""");
      value.close();
      completer.complete();
    }
  });
  for (var i = 1; i <= times; i++) {
    value.add(i);
  }
  return completer.future;
}
