import 'base_notifier.dart';
import 'package:meta/meta.dart' show mustCallSuper;

abstract class StateNotifier<State> extends BaseNotifier<State> {
  late State _state, _oldState;
  State get state => _state;
  State get oldState => _oldState;

  StateNotifier(State initialState) {
    _state = initialState;
    _oldState = _state;
  }

  /// Update the State and  notify to listeners and rebuild the widgets
  ///
  /// [state] must be different of the current state
  set state(State newState) {
    assert(!disposed, 'A $runtimeType was used after being disposed.');
    if (onStateWillChange(_state, newState)) {
      _oldState = _state;
      _state = newState;
      onStateChanged(_oldState, _state);
      super.notify(_state);
    }
  }

  /// this method is called when the state is going to be updated
  /// By default this method returns true, you can use this method to intercept the [newState]
  /// and check if the new state is valid.
  /// If this method returns false the new state will be igonored
  bool onStateWillChange(State oldState, State newState) =>
      oldState != newState;

  /// this method is called when the state has been changed
  void onStateChanged(State oldState, State currentState) {}

  /// use to listen when the controller was deleted from memory
  @override
  @mustCallSuper
  void onDispose() async {
    super.onDispose();
  }
}
