part of '../base_provider.dart';

class StateTagProvider<T extends StateNotifier<S>, S> extends TagProvider<T> {
  StateTagProvider({
    required _LazyCallback<T> creator,
    required bool autoDispose,
  }) : super(creator, autoDispose);

  /// get or create a provider by a tag name
  StateProvider<T, S> find(String tagName) {
    if (!_providers.containsKey(tagName)) {
      final provider = StateProvider<T, S>(
        creator,
        autoDispose: autoDispose,
        onDisposed: () {
          _providers.remove(tagName);
        },
      );
      _providers[tagName] = provider;
      return provider;
    }
    return _providers[tagName]! as StateProvider<T, S>;
  }
}

abstract class TagProvider<P> {
  /// the creator function for all providers
  final _LazyCallback<P> creator;

  /// if the auto dispose is enabled for all providers
  final bool autoDispose;

  /// contain all providers
  final Map<String, BaseProvider<P>> _providers = {};

  /// returns the number of providers saved
  @visibleForTesting
  int get count => _providers.length;

  TagProvider(this.creator, this.autoDispose);

  BaseProvider<P> find(String tagName);

  /// set the arguments for one provider
  void setArguments(String tagName, dynamic arguments) {
    final provider = find(tagName);
    provider.setArguments(arguments);
  }

  /// clear and dispose all providers
  void clear() {
    _providers.values.forEach((element) {
      if (element.mounted) {
        element.dispose(avoidOnDisposeCallback: true);
      }
    });
    _providers.clear();
  }
}
