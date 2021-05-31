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
          clearOverridden();
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
  final _LazyCallback<P> _creator;

  /// callback to override the main creator callback
  _LazyCallback<P>? _overriddenCreator;

  _LazyCallback<P> get creator => _overriddenCreator ?? _creator;

  /// if the auto dispose is enabled for all providers
  final bool _autoDispose;

  /// boolean to override the main autoDispose
  bool? _overriddenAutoDispose;

  bool get autoDispose => _overriddenAutoDispose ?? _autoDispose;

  /// contain all providers
  final Map<String, BaseProvider<P>> _providers = {};

  /// returns the number of providers saved
  @visibleForTesting
  int get count => _providers.length;

  TagProvider(this._creator, this._autoDispose);

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

  /// overrides the creator function of this tag provider useful for unit test.
  @visibleForTesting
  void overrideTagProvider(
    _LazyCallback<P> creator, {
    bool? autoDispose,
  }) {
    clear();
    _overriddenCreator = creator;
    _overriddenAutoDispose = autoDispose;
  }

  @visibleForOverriding
  void clearOverridden() {
    _overriddenAutoDispose = null;
    _overriddenCreator = null;
  }
}
