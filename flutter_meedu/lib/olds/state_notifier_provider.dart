part of 'base_provider.dart';

class StateNotifierProvider<N extends StateNotifier<State>, State>
    extends BaseProvider<N, dynamic> implements ListeneableProvider<N> {
  StateNotifierProvider(
    super.creator, {
    super.autoDispose,
    super.onDisposed,
  });

  static StateNotifierProviderWithArguments<N, State, Arguments>
      withArguments<N extends StateNotifier<State>, State, Arguments>(
    Creator<N, Arguments> creator, {
    bool autoDispose = true,
  }) {
    return StateNotifierProviderWithArguments(
      creator,
      autoDispose: autoDispose,
    );
  }
}

class StateNotifierProviderWithArguments<N extends StateNotifier<State>, State,
        Arguments> extends BaseProvider<N, Arguments>
    implements ListeneableProvider<N> {
  StateNotifierProviderWithArguments(
    super._creator, {
    super.autoDispose,
  });
}

class StateTagProvider<N extends StateNotifier<S>, S>
    extends BaseTagProvider<N, dynamic> {
  StateTagProvider(
    super.creator,
    super.autoDispose,
  );

  /// get or create a provider by a tag name
  @override
  StateNotifierProvider<N, S> find(String tagName) {
    if (!_providers.containsKey(tagName)) {
      final provider = StateNotifierProvider<N, S>(
        creator,
        autoDispose: autoDispose,
        onDisposed: () {
          _providers.remove(tagName);
        },
      );
      _providers[tagName] = provider;
      return provider;
    }
    return _providers[tagName]! as StateNotifierProvider<N, S>;
  }
}
