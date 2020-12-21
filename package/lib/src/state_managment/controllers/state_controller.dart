import 'dart:async';

import 'package:meedu/src/state_managment/controllers/base_controller.dart';
import 'package:flutter/foundation.dart' show mustCallSuper;

abstract class StateController<S> extends BaseController<S> {
  S _state, _oldState;
  S get state => _state;

  StateController(S initialState) {
    _state = initialState;
    _oldState = _state;
  }

  /// Update the State and  notify to listeners and rebuild the widgets
  ///
  /// [state] must be different of the current state
  void update(S state) {
    if (_state != state) {
      if (onStateWillChange(_oldState, state)) {
        _oldState = _state;
        _state = state;
        onStateChanged(_oldState, _state);
        notify(state);
      }
    }
  }

  /// this method is called when the state is going to be updated
  /// By default this method returns true, you can use this method to intercept the [newState]
  /// and check if the new state is valid.
  /// If this method returns false the new state will be igonored
  bool onStateWillChange(S oldState, S newState) => true;

  /// this method is called when the state has been changed
  void onStateChanged(S oldState, S currentState) {}

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  @override
  @mustCallSuper
  void onInit() {
    super.onInit();
  }

  /// when the MeeduBuilder was mounted
  @override
  void afterFirstLayout() {}

  /// use to listen when the controller was deleted from memory
  @override
  @mustCallSuper
  Future<void> onDispose() async {
    super.onDispose();
  }
}
