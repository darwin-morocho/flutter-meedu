import 'package:meedu/rx.dart';
import 'package:test/test.dart';

void main() {
  test('obs extensions test good', () {
    Rx<int> counter = 10.obs;
    Rx<double> price = 0.99.obs;
    Rx<bool> isActive = false.obs;
    Rx<String> name = "false".obs;

    expect(counter.value, isA<int>());
    expect(price.value, isA<double>());
    expect(isActive.value, isA<bool>());
    expect(name.value, isA<String>());
  });
}
