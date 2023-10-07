import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('obs extensions test good', () {
    var counter = 10.obs;
    var price = 0.99.obs;
    var isActive = false.obs;
    var name = 'false'.obs;

    expect(counter.value, isA<int>());
    expect(price.value, isA<double>());
    expect(isActive.value, isA<bool>());
    expect(name.value, isA<String>());
  });
}
