part of '../base_provider.dart';

class SimpleTagProvider<T extends SimpleNotifier> extends TagProvider<T> {
  SimpleTagProvider({
    required _LazyCallback<T> creator,
    required bool autoDispose,
  }) : super(creator, autoDispose);

  /// get or create a provider by a tag name
  @override
  SimpleProvider<T> find(String tagName) {
    if (!_providers.containsKey(tagName)) {
      final provider = SimpleProvider<T>(
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
    return _providers[tagName]! as SimpleProvider<T>;
  }
}
