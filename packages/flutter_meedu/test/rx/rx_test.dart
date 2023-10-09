
import 'package:flutter_meedu/rx.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rx changes', () async {
    final counter = Rx<int>(0);
    expect(counter.value, 0);
    // check the stream events
    var values = <int?>[counter.value];
    counter.stream.listen((event) {
      values.add(event);
    });

    // after 5 iterations the Rx must notified 5 times
    const length = 5;
    for (var i = 1; i <= length; i++) {
      counter.value = i;
    }
    await Future.delayed(Duration(seconds: 1));
    await counter.close();
    expect(values.length, length + 1);
  });
}
