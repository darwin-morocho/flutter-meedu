import 'package:meedu/provider.dart';
import 'package:test/test.dart';

import 'simple_provider_test.dart';

void main() {
  setUp(() {
    _simpleTagProvider.clear();
  });

  test('SimpleTagProvider', () {
    expect(_simpleTagProvider.count, 0);
    _simpleTagProvider.setArguments('1', 10);
    final provider1 = _simpleTagProvider.find('1');
    final provider2 = _simpleTagProvider.find('2');
    expect(_simpleTagProvider.count, 2);

    final controller1 = provider1.read;
    final controller2 = provider2.read;

    expect(controller1.counter, 10);
    expect(controller2.counter, 0);

    _simpleTagProvider.find('1').read.increment();
    _simpleTagProvider.find('2').read.increment();
    expect(controller1.counter, 11);
    expect(controller2.counter, 1);
    provider1.dispose();
    provider2.dispose();
    expect(_simpleTagProvider.count, 0);
    expect(controller1.disposed, true);
    expect(controller2.disposed, true);
    _simpleTagProvider.find('2').read;
    expect(_simpleTagProvider.count, 1);
    _simpleTagProvider.clear();
    expect(_simpleTagProvider.count, 0);
  });

  test('SimpleTagProvider override creator', () {
    expect(_simpleTagProvider.count, 0);
    var controller = _simpleTagProvider.find('tagName').read;
    expect(controller.counter, 0);
    _simpleTagProvider.overrideTagProvider(
      (ref) => CounterController(counter: 20),
    );
    controller = _simpleTagProvider.find('tagName').read;
    expect(controller.counter, 20);
  });
}

final _simpleTagProvider = SimpleProvider.withTag(
  (ref) => CounterController(counter: ref.arguments ?? 0),
);
