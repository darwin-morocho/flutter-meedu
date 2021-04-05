import 'base_notifier.dart';
import 'package:meta/meta.dart' show mustCallSuper;

abstract class StateNotifier<S> extends BaseNotifier<S> {
  late S _state, _oldState;
  S get state => _state;

  StateNotifier(S initialState) {
    _state = initialState;
    _oldState = _state;
  }

  /// Update the State and  notify to listeners and rebuild the widgets
  ///
  /// [state] must be different of the current state
  set state(S state) {
    assert(!disposed, 'A $runtimeType was used after being disposed.');
    if (onStateWillChange(_oldState, state)) {
      _oldState = _state;
      _state = state;
      onStateChanged(_oldState, _state);
      notifyListeners(state);
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
  void onInit() {}

  /// when the MeeduBuilder was mounted
  @override
  void onAfterFirstLayout() {}

  /// use to listen when the controller was deleted from memory
  @override
  @mustCallSuper
  void onDispose() async {
    super.onDispose();
  }
}
