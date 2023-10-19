import 'package:meedu/providers.dart';
import 'package:test/test.dart';

void main() {
  setUp(ProvidersContainer.clear);

  test(
    'Provider',
    () {
      // expect(() => _provider.mounted(tag: ''), throwsAssertionError);
      expect(_provider.mounted(), false);
      final repo = _provider.read();
      expect(
        repo.hashCode,
        _provider.read().hashCode,
      );
      expect(repo.apiKey, '');
      expect(repo.dispose, false);
      expect(_provider.mounted(), true);
      _provider.dispose();
      expect(_provider.mounted(), false);
      expect(repo.dispose, true);
    },
  );

  test(
    'Provider > tag',
    () {
      // expect(() => _tagProvider.read(), throwsAssertionError);
      final repo1 = _tagProvider.read(tag: 'user1');
      final repo2 = _tagProvider.read(tag: 'user2');
      expect(
        repo1.hashCode,
        isNot(repo2.hashCode),
      );
      expect(
        repo1.hashCode,
        isNot(
          _tagProvider.read(tag: 'user1'),
        ),
      );
    },
  );

  test(
    'ArgumentsProvider',
    () {
      expect(
        () => _argumentsProvider.read(),
        throwsA(isA<AssertionError>()),
      );
      _argumentsProvider.setArguments('hello');

      final repo = _argumentsProvider.read();
      expect(
        repo.apiKey,
        'hello',
      );
      expect(
        repo.hashCode,
        _argumentsProvider.read().hashCode,
      );
    },
  );

  test(
    'TagArgumentsProvider',
    () {
      _argumentsTagProvider.setArguments('hello', tag: '1');

      final repo = _argumentsTagProvider.read(tag: '1');
      expect(
        repo.apiKey,
        'hello',
      );
      expect(
        repo.hashCode,
        _argumentsTagProvider.read(tag: '1').hashCode,
      );
    },
  );

  test(
    'FactoryProvider',
    () {
      expect(
        () => _factoryProvider.read(),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => _factoryProvider.mounted(),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => _factoryProvider.dispose(),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => _factoryProvider.setArguments('', tag: ''),
        throwsA(isA<AssertionError>()),
      );

      final element1 = _factoryProvider.get();
      final element2 = _factoryProvider.get();

      expect(
        element1.value.hashCode,
        isNot(element2.value.hashCode),
      );

      element1.dispose();
      expect(element1.value.dispose, true);
      expect(element2.value.dispose, false);

      element2.dispose();
      expect(element2.value.dispose, true);
    },
  );

  test(
    'FactoryArgumentsProvider',
    () {
      final element1 = _factoryArgumentsProvider.get('key1');
      final element2 = _factoryArgumentsProvider.get('key2');

      expect(
        element1.value.hashCode,
        isNot(element2.value.hashCode),
      );

      expect(element1.value.apiKey, 'key1');
      expect(element2.value.apiKey, 'key2');
      element1.dispose();
      expect(element1.value.dispose, true);
    },
  );
}

final _provider = Provider(
  (ref) {
    final repo = GoogleMapsRepo('');
    ref.onDispose(
      () {
        repo.dispose = true;
      },
    );
    return repo;
  },
);

final _tagProvider = Provider.tag(
  (ref) {
    final repo = GoogleMapsRepo('');
    ref.onDispose(
      () {
        repo.dispose = true;
      },
    );
    return repo;
  },
);

final _argumentsProvider = Provider.arguments<GoogleMapsRepo, String>(
  (ref) => GoogleMapsRepo(
    ref.arguments,
  ),
);

final _argumentsTagProvider = Provider.argumentsTag<GoogleMapsRepo, String>(
  (ref) => GoogleMapsRepo(
    ref.arguments,
  ),
);

final _factoryProvider = FactoryProvider(
  (ref) {
    final repo = GoogleMapsRepo('');
    ref.onDispose(
      () {
        repo.dispose = true;
      },
    );
    return repo;
  },
);

final _factoryArgumentsProvider =
    FactoryProvider.arguments<GoogleMapsRepo, String>(
  (ref) {
    final repo = GoogleMapsRepo(ref.arguments);

    ref.onDispose(() {
      repo.dispose = true;
    });

    return repo;
  },
);

class GoogleMapsRepo {
  GoogleMapsRepo(this.apiKey);

  final String apiKey;
  bool dispose = false;
}
