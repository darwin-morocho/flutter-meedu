import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/provider_scope.dart';
import 'package:flutter_test/flutter_test.dart';

final _provider =
    StateNotifierProvider.withArguments<CounterNotifier, int, int>(
  (ref) => CounterNotifier(ref.arguments),
);

final _googleMapsProvider =
    Provider.factoryWithArguments<GoogleMapsRepo, String>(
  (ref) => GoogleMapsRepo(
    apiKey: ref.arguments,
  ),
);

void main() {
  setUp(ProviderScope.clear);

  test(
    'assertion arguments',
    () {
      expect(() => _provider.read, throwsAssertionError);
    },
  );

  test(
    'arguments ok',
    () {
      _provider.setArguments(100);
      expect(_provider.read.state, 100);
      _provider.read.increment();
      expect(_provider.read.state, 101);
    },
  );

  test(
    'assertion arguments',
    () {
      expect(() => _provider.read, throwsAssertionError);
    },
  );

  test(
    'Provider',
    () {
      bool disposed = false;
      final provider = Provider(
        (ref) {
          ref.onDispose(
            () {
              disposed = true;
            },
          );
          return GoogleMapsRepo(apiKey: 'apiKey');
        },
      );
      expect(provider.mounted, false);
      expect(
        provider.read.hashCode,
        provider.read.hashCode,
      );
      expect(provider.mounted, true);

      provider.dispose();
      expect(provider.mounted, false);
      expect(disposed, true);
    },
  );

  test(
    'Provider with arguments',
    () {
      final provider = Provider.withArguments<GoogleMapsRepo, String>(
        (ref) => GoogleMapsRepo(
          apiKey: ref.arguments,
        ),
      );
      provider.setArguments('darwin');
      expect(provider.read.hashCode, provider.read.hashCode);
      expect(provider.read.apiKey, 'darwin');
      provider.dispose();
      expect(provider.mounted, false);
    },
  );

  test(
    'factory with argments',
    () {
      final repo = _googleMapsProvider.get('key1');
      expect(repo.printApiKey(), 'key: key1');
      expect(
        repo.hashCode,
        isNot(_googleMapsProvider.get('key1').hashCode),
      );
    },
  );

  test(
    'factory ',
    () {
      final provider = Provider.factory(
        (_) => GoogleMapsRepo(apiKey: ''),
      );

      expect(
        provider.read.hashCode,
        isNot(provider.read.hashCode),
      );
    },
  );
}

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(super.initialState);

  void increment() => state++;
}

class GoogleMapsRepo {
  final String apiKey;

  GoogleMapsRepo({
    required this.apiKey,
  });

  String printApiKey() => 'key: $apiKey';
}
