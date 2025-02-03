import 'dart:async';

import 'package:meta/meta.dart';

import 'base_notifier.dart';

part 'persistent_state_mixin.dart';

class StateNotifier<S> extends BaseNotifier<S> with ListeneableNotifier<S> {
  StateNotifier(S initialState) {
    _initialState = initialState;
    _state = _initialState;
    _oldState = _state;
  }

  late S _initialState, _state, _oldState;

  /// Returns the initial state value.
  S get initialState => _initialState;

  S get state => _state;
  S get oldState => _oldState;

  /// Updates the State and notify to listeners and rebuild the widgets
  ///
  /// [state] must be different of the current state
  @protected
  set state(S newState) {
    _update(newState);
  }

  /// updates the state but does not notify to the listeners
  @protected
  void onlyUpdate(S newState) {
    _update(newState, false);
  }

  /// changes the state value
  /// if [notify] is false it doesn't notify to all listeners
  void _update(S newState, [bool notify = true]) {
    if (!disposed && onStateWillChange(_state, newState)) {
      _oldState = _state;
      _state = newState;
      onStateChanged(_oldState, _state);
      if (notify) {
        notifyListeners(_state);
      }
    }
  }

  /// this method is called when the state is going to be updated
  /// By default this method returns true, you can use this method to intercept the [newState]
  /// and check if the new state is valid.
  /// If this method returns false the new state will be igonored
  bool onStateWillChange(S oldState, S newState) => oldState != newState;

  /// this method is called when the state has been changed
  void onStateChanged(S oldState, S currentState) {}

  @protected
  @mustCallSuper
  @override
  FutureOr<void> dispose() {
    super.dispose();
    clearListeners();
  }
}
