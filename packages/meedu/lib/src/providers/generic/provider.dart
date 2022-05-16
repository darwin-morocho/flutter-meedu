part of '../base_provider.dart';

class Provider<T> extends BaseProvider<T> {
  Provider(
    super.creator, {
    super.autoDispose = true,
    super.onDisposed,
  });

  static TagProvider<T> withTag<T>(
    _LazyCallback<T> creator, {
    bool autoDispose = true,
  }) {
    return TagProvider<T>(
      creator: creator,
      autoDispose: autoDispose,
    );
  }
}

class TagProvider<T> extends BaseTagProvider<T> {
  TagProvider({
    required _LazyCallback<T> creator,
    required bool autoDispose,
  }) : super(creator, autoDispose);

  /// get or create a provider by a tag name
  @override
  Provider<T> find(String tagName) {
    if (!_providers.containsKey(tagName)) {
      final provider = Provider<T>(
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
    return _providers[tagName]! as Provider<T>;
  }
}
