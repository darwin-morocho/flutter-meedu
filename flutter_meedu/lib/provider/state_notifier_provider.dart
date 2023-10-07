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

  static StateTagProvider<N, S> withTag<N extends StateNotifier<S>, S>(
    Creator<N, dynamic> creator, {
    bool autoDispose = true,
  }) {
    return StateTagProvider(
      creator,
      autoDispose,
    );
  }

  static StateTagProviderWithArguments<N, S, A>
      withArgumentsTag<N extends StateNotifier<S>, S, A>(
    Creator<N, A> creator, {
    bool autoDispose = true,
  }) {
    return StateTagProviderWithArguments(
      creator,
      autoDispose,
    );
  }
}

class StateNotifierProviderWithArguments<N extends StateNotifier<State>, State,
        Arguments> extends BaseProvider<N, Arguments>
    implements ListeneableProvider<N> {
  StateNotifierProviderWithArguments(
    super._creator, {
    super.autoDispose,
    super.onDisposed,
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
          if (_providers.isEmpty && _overriddenCreator != null) {
            clearOverridden();
          }
        },
      );
      _providers[tagName] = provider;
      return provider;
    }
    return _providers[tagName]! as StateNotifierProvider<N, S>;
  }
}

class StateTagProviderWithArguments<N extends StateNotifier<S>, S, A>
    extends BaseTagProvider<N, A> {
  StateTagProviderWithArguments(
    super.creator,
    super.autoDispose,
  );

  /// get or create a provider by a tag name
  @override
  StateNotifierProviderWithArguments<N, S, A> find(String tagName) {
    if (!_providers.containsKey(tagName)) {
      final provider = StateNotifierProviderWithArguments<N, S, A>(
        creator,
        autoDispose: autoDispose,
        onDisposed: () {
          _providers.remove(tagName);
          if (_providers.isEmpty && _overriddenCreator != null) {
            clearOverridden();
          }
        },
      );
      _providers[tagName] = provider;
      return provider;
    }
    return _providers[tagName]! as StateNotifierProviderWithArguments<N, S, A>;
  }
}
