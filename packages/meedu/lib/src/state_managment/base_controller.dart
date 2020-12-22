import 'dart:async';
import 'package:meta/meta.dart' show mustCallSuper;

/// this class define the basic Listener for each SimpleController's subscriber or StateController's subscriber
class BaseListener<T> {
  final void Function(T) listener;
  BaseListener(this.listener);
}

/// Define a base controller for SimpleController and StateController
abstract class BaseController<T> {
  /// list to save the subscribers
  List<BaseListener<T>> _listeners = [];

  /// Tell us if the controller was disposed
  bool get disposed => _listeners == null;

  /// check if the controller is mounted
  void _debugAssertNotDisposed() {
    assert(_listeners != null, 'A $runtimeType was used after being disposed.');
  }

  /// add a new listener
  void addListener(BaseListener listener) {
    _debugAssertNotDisposed();
    _listeners.add(listener);
  }

  /// remove a listener
  void removeListener(BaseListener listener) {
    _debugAssertNotDisposed();
    _listeners.remove(listener);
  }

  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void notify([T data]) {
    _debugAssertNotDisposed();
    _listeners.forEach((e) {
      e.listener(data);
    });
  }

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  void onInit();

  /// when the MeeduBuilder was mounted
  void afterFirstLayout();

  /// use to listen when the controller was deleted from memory
  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  Future<void> onDispose() async {
    _debugAssertNotDisposed();
    _listeners.clear();
    _listeners = null;
  }
}
