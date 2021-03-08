import 'package:meedu/rx.dart';
import 'package:test/test.dart';

void main() {
  test('rx changes', () async {
    final counter = Rx<int>(0);
    expect(counter.value, 0);
    // check the stream events
    List<int?> values = [counter.value];
    counter.stream.listen((event) {
      values.add(event);
    });

    // after 5 iterations the Rx must notified 5 times
    const length = 5;
    for (int i = 1; i <= length; i++) {
      counter.value = i;
    }
    await Future.delayed(Duration(seconds: 1));
    await counter.close();
    expect(values.length, length + 1);
  });
}
