import 'package:meedu/meedu.dart';
import 'package:test/test.dart';

void main() {
  tearDown(() {
    ProviderScope.clear();
  });
  group('normal flow', () {
    test('> not mounted', () {
      expect(_simpleProvider.mounted, false);
    });

    test('> mounted', () {
      _simpleProvider.read;
      expect(_simpleProvider.mounted, true);
    });

    test('> arguments', () {
      _simpleProvider.setArguments(100);
      expect(_simpleProvider.read.counter, 100);
    });

    test('> notify', () async {
      expect(_simpleProvider.mounted, false);
      final controller = _simpleProvider.read;
      expect(controller.disposeCalled, false);
      final stream = controller.stream;
      expect(_simpleProvider.mounted, true);
      stream.listen(
        expectAsync1((_) {
          expect(_, isA<SimpleNotifierEmptyData>());
        }, count: 4),
      );

      controller.increment();
      controller.increment();
      controller.increment();
      _simpleProvider.read.increment();
      _simpleProvider.dispose();
      expect(controller.disposeCalled, true);
    });
  });

  group('overrride flow', () {
    test('> update provider', () async {
      final firstController = _simpleProvider.read;
      expect(firstController.counter, 0);
      _simpleProvider.overrideProvider((_) => CounterController(counter: 10));
      expect(firstController.disposed, true);
      final secondController = _simpleProvider.read;
      expect(secondController.counter, 10);
      _simpleProvider.dispose();
      expect(secondController.disposed, true);
      expect(_simpleProvider.read.counter, 0);
    });
  });
}

class CounterController extends SimpleNotifier {
  int counter;
  CounterController({this.counter = 0});

  bool disposeCalled = false;

  void increment() {
    counter++;
    notify();
  }

  @override
  void dispose() {
    disposeCalled = true;
    super.dispose();
  }
}

final _simpleProvider = SimpleProvider(
  (_) => CounterController(counter: _.arguments ?? 0),
  autoDispose: false,
);
