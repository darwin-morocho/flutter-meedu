import 'package:flutter_meedu/providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(ProvidersContainer.clear);

  test(
    'Provider',
    () {
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
      final repo1 = _provider.read(tag: 'user1');
      final repo2 = _provider.read(tag: 'user2');
      expect(
        repo1.hashCode,
        isNot(repo2.hashCode),
      );
      expect(
        repo1.hashCode,
        isNot(
          _provider.read(tag: 'user1'),
        ),
      );
    },
  );

  test(
    'ArgumentsProvider',
    () {
      expect(
        () => _argumentsProvider.read(),
        throwsAssertionError,
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

final _argumentsProvider = Provider.withArguments<GoogleMapsRepo, String>(
  (ref) => GoogleMapsRepo(
    ref.arguments,
  ),
);

class GoogleMapsRepo {
  GoogleMapsRepo(this.apiKey);

  final String apiKey;
  bool dispose = false;
}
