part of '../base_provider.dart';

class StateProvider<T extends StateNotifier<S>, S> extends BaseProvider<T>
    with ListeneableProvider<T> {
  StateProvider(
    super.creator, {
    super.autoDispose = true,
    super.onDisposed,
  });

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
