import 'package:meedu/meedu.dart';
import 'package:test/test.dart';

void main() {
  tearDown(() {
    if (simpleProvider.mounted) {
      simpleProvider.dispose();
    }
  });
  group('normal flow', () {
    test('> not mounted', () {
      expect(simpleProvider.mounted, false);
    });

    test('> mounted', () {
      simpleProvider.read;
      expect(simpleProvider.mounted, true);
    });

    test('> notify', () async {
      expect(simpleProvider.mounted, false);
      final controller = simpleProvider.read;
      expect(controller.disposeCalled, false);
      final stream = controller.stream;
      expect(simpleProvider.mounted, true);
      stream.listen(
        expectAsync1((_) {
          expect(_.length, 0);
        }, count: 4),
      );

      controller.increment();
      controller.increment();
      controller.increment();
      controller.increment();
      simpleProvider.dispose();
      expect(
        () {
          controller.increment();
        },
        throwsA(isA<AssertionError>()),
      );
      expect(controller.disposeCalled, true);
    });
  });

  group('overrride flow', () {
    test('> update provider', () async {
      final firstController = simpleProvider.read;
      expect(firstController.counter, 0);
      simpleProvider.overrideProvider((_) => Controller(counter: 10));
      expect(firstController.disposed, true);
      final secondController = simpleProvider.read;
      expect(secondController.counter, 10);
      simpleProvider.dispose();
      expect(secondController.disposed, true);
      expect(simpleProvider.read.counter, 0);
    });
  });
}

class Controller extends SimpleNotifier {
  int counter;
  Controller({this.counter = 0});

  bool disposeCalled = false;

  void increment() {
    counter++;
    notify();
  }

  @override
  void onDispose() {
    disposeCalled = true;
    super.onDispose();
  }
}

final simpleProvider = SimpleProvider(
  (_) => Controller(),
  autoDispose: false,
);
