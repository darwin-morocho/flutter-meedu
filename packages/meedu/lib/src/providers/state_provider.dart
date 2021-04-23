part of 'base_provider.dart';

class StateProvider<T extends StateNotifier<S>, S> extends BaseProvider<T> {
  StateProvider(
    _LazyCallback<T> create, {
    bool autoDispose = true,
  }) : super(
          create,
          autoDispose,
        );
}
