part of '../base_provider.dart';

class StateTagProvider<T extends StateNotifier<S>, S>
    extends BaseTagProvider<T> {
  StateTagProvider({
    required _LazyCallback<T> creator,
    required bool autoDispose,
  }) : super(creator, autoDispose);

  /// get or create a provider by a tag name
  @override
  StateProvider<T, S> find(String tagName) {
    if (!_providers.containsKey(tagName)) {
      final provider = StateProvider<T, S>(
        creator,
        autoDispose: autoDispose,
        onDisposed: () {
          _providers.remove(tagName);
          clearOverridden();
        },
      );
      _providers[tagName] = provider;
      return provider;
    }
    return _providers[tagName]! as StateProvider<T, S>;
  }
}
