part of 'base_provider.dart';

typedef _BuildWhen<S> = bool Function(S prevState, S currentState);

class StateProvider<T extends StateNotifier<S>, S> extends BaseProvider<T> {
  late S _oldState;
  S get oldState => _oldState;
  _BuildWhen<S>? _buildWhen;
  _BuildWhen<S>? get buildWhen => _buildWhen;

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

  StateProvider<T, S> select(_BuildWhen<S> buildWhen) {
    _buildWhen = buildWhen;
    return this;
  }

  void clearBuildWhen() {
    _buildWhen = null;
  }
}
