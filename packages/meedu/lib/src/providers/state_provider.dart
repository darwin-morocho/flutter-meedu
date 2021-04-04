part of 'base_provider.dart';

class StateProvider<T extends StateNotifier<S>, S> extends BaseProvider<T> {
  late S _oldState;
  S get oldState => _oldState;

  StateProvider(_LazyCallback<T> create, [bool autoDispose = false])
      : super(
          create,
          autoDispose,
        );

  static StateProvider<T, S> autoDispose<T extends StateNotifier<S>, S>(
    _LazyCallback<T> create,
  ) {
    return StateProvider(create, true);
  }

  void setOldState(S newState) {
    _oldState = newState;
  }
}
