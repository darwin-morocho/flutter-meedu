// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(ProvidersContainer.clear);

  test(
    'StateNotifierProvider > overrideCreator',
    () {
      _provider.overrideCreator(
        (_) => SearchNotifier('override'),
        autoDispose: false,
      );
      final notifier = _provider.read();
      expect(
        notifier.hashCode,
        _provider.read().hashCode,
      );
      final void Function(String) listener = (_) {};
      notifier.addListener(listener);
      expect(notifier.mounted, true);
      expect(notifier.state, 'override');
      notifier.removeListener(listener);
      expect(notifier.mounted, true);
      _provider.dispose();
      expect(notifier.mounted, false);
      expect(_provider.mounted(), false);
    },
  );
  test(
    'StateNotifierProvider',
    () async {
      final notifier = _provider.read();
      expect(notifier.state, '');

      final void Function(String) listener = (_) {};
      notifier.addListener(listener);
      expect(notifier.mounted, true);
      notifier.update('hello');
      expect(notifier.state, 'hello');
      notifier.removeListener(listener);
      expect(notifier.mounted, false);
      expect(_provider.mounted(), false);
    },
  );

  test(
    'StateNotifierArgumentsProvider',
    () async {
      _argumentsProvider.setArguments('init');
      final notifier = _argumentsProvider.read();
      expect(notifier.state, 'init');
    },
  );
}

final _provider = StateNotifierProvider<SearchNotifier, String>(
  (_) => SearchNotifier(''),
  autoDispose: true,
);

final _argumentsProvider =
    StateNotifierProvider.withArguments<SearchNotifier, String, String>(
  (ref) => SearchNotifier(ref.arguments),
  autoDispose: true,
);

class SearchNotifier extends StateNotifier<String> {
  SearchNotifier(super.initialState);

  void update(String value) {
    state = value;
  }
}
