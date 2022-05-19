part of '../base_provider.dart';

class SimpleProvider<T> extends BaseProvider<T> with ListeneableProvider<T> {
  SimpleProvider(
    super.creator, {
    super.autoDispose = true,
    super.onDisposed,
  });

  static SimpleTagProvider<T> withTag<T extends SimpleNotifier>(
    _LazyCallback<T> creator, {
    bool autoDispose = true,
  }) {
    return SimpleTagProvider<T>(
      creator: creator,
      autoDispose: autoDispose,
    );
  }
}
