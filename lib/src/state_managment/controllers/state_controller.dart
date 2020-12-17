import 'dart:async';

import 'package:meedu/src/state_managment/controllers/base_controller.dart';
import 'package:flutter/foundation.dart' show mustCallSuper;

abstract class StateController<S> extends BaseController<S> {
  S _state;
  S get state => _state;
  S get initialState;

  StateController() {
    _state = initialState;
  }

  /// Update the State and  notify to listeners and rebuild the widgets
  ///
  /// [state] must be different of the current state
  void update(S state) {
    if (_state != state) {
      _state = state;
      notify(state);
    }
  }

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  @override
  void onInit() {}

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
