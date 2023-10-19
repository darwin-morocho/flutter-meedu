

import 'package:meedu/notifiers.dart';
import 'package:meedu/providers.dart';
import 'package:test/test.dart';

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
      // ignore: omit_local_variable_types
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

  test(
    'StateNotifierTagProvider',
    () async {
      final notifier1 = _providerStateTag.read(tag: '1');
      final notifier = _providerStateTag.read(tag: '2');
      expect(notifier.hashCode != notifier1.hashCode, true);
    },
  );

  test(
    'StateNotifierTagArgumentsProvider',
    () async {
      _argumentsTagProvider.setArguments('init1', tag: '1');
      _argumentsTagProvider.setArguments('init2', tag: '2');
      expect(_argumentsTagProvider.read(tag: '1').state, 'init1');
      expect(_argumentsTagProvider.read(tag: '2').state, 'init2');
    },
  );
}

final _provider = Provider.state<SearchNotifier, String>(
  (_) => SearchNotifier(''),
  autoDispose: true,
);

final _providerStateTag = Provider.stateTag<SearchNotifier, String>(
  (_) => SearchNotifier(''),
  autoDispose: true,
);

final _argumentsProvider =
    Provider.stateArguments<SearchNotifier, String, String>(
  (ref) => SearchNotifier(ref.arguments),
  autoDispose: true,
);

final _argumentsTagProvider =
    Provider.stateArgumentsTag<SearchNotifier, String, String>(
  (ref) => SearchNotifier(ref.arguments),
  autoDispose: true,
);

class SearchNotifier extends StateNotifier<String> {
  SearchNotifier(super.initialState);

  void update(String value) {
    state = value;
  }
}
