part of '../base_provider.dart';

class StateProvider<T extends StateNotifier<S>, S> extends BaseProvider<T> {
  StateProvider(
    _LazyCallback<T> creator, {
    bool autoDispose = true,
    void Function()? onDisposed,
  }) : super(
          creator,
          autoDispose: autoDispose,
          onDisposed: onDisposed,
        );

  static StateTagProvider<T, S> withTag<T extends StateNotifier<S>, S>(
    _LazyCallback<T> creator, {
    bool autoDispose = true,
  }) {
    return StateTagProvider<T, S>(
      creator: creator,
      autoDispose: autoDispose,
    );
  }
}
