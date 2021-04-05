part of 'base_provider.dart';

class StateProvider<T extends StateNotifier<S>, S> extends BaseProvider<T> {
  late S _oldState;
  S get oldState => _oldState;

  StateProvider(
    _LazyCallback<T> create, {
    bool autoDispose = true,
  }) : super(
          create,
          autoDispose,
        );

  void setOldState(S newState) {
    _oldState = newState;
  }
}
