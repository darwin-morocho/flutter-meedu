import 'dart:collection';
import 'package:meta/meta.dart' show mustCallSuper;

typedef ListenerCallback<T> = void Function(T);

/// this class define the basic Listener for each SimpleController's subscriber or StateController's subscriber
class _ListenerEntry<T> extends LinkedListEntry<_ListenerEntry<T>> {
  final ListenerCallback<T> listener;
  _ListenerEntry(this.listener);
}

/// Define a base controller for SimpleController and StateController
abstract class BaseController<T> {
  /// list to save the subscribers
  LinkedList<_ListenerEntry<T>>? _listeners = LinkedList<_ListenerEntry<T>>();

  /// Tell us if the controller was disposed
  bool get disposed => _listeners == null;

  bool get hasListeners => !disposed ? _listeners!.isNotEmpty : false;

  /// check if the controller is mounted
  void _debugAssertNotDisposed() {
    assert(_listeners != null, 'A $runtimeType was used after being disposed.');
  }

  /// add a new listener
  void addListener(ListenerCallback<T> listener) {
    _debugAssertNotDisposed();
    _listeners!.add(_ListenerEntry<T>(listener));
  }

  /// remove a listener
  void removeListener(ListenerCallback<T> listener) {
    if (_listeners != null) {
      for (final _ListenerEntry<T> entry in _listeners!) {
        if (entry.listener == listener) {
          entry.unlink();
          return;
        }
      }
    }
  }

  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void notify(T data) {
    _debugAssertNotDisposed();

    if (_listeners!.isNotEmpty) {
      for (final _ListenerEntry<T> entry in _listeners!) {
        if (entry.list != null) entry.listener(data);
      }
    }
  }

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  void onInit();

  /// when the MeeduBuilder was mounted
  void onAfterFirstLayout();

  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  void onDispose() async {
    _debugAssertNotDisposed();
    _listeners!.clear();
    _listeners = null;
  }
}
