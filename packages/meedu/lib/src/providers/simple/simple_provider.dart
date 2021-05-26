part of '../base_provider.dart';

class SimpleProvider<T> extends BaseProvider<T> {
  SimpleProvider(
    _LazyCallback<T> creator, {
    bool autoDispose = true,
    void Function()? onDisposed,
  }) : super(
          creator,
          autoDispose: autoDispose,
          onDisposed: onDisposed,
        );

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
