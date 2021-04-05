import 'dart:async';
import 'dart:collection';
import 'package:meta/meta.dart' show mustCallSuper, protected;

typedef ListenerCallback<T> = void Function(T);

/// this class define the basic Listener for each SimpleController's subscriber or StateController's subscriber
class _ListenerEntry<T> extends LinkedListEntry<_ListenerEntry<T>> {
  final ListenerCallback<T> listener;
  final bool autoDispose;
  _ListenerEntry(this.listener, this.autoDispose);
}

/// Define a base controller for SimpleController and StateController
abstract class BaseNotifier<T> {
  /// list to save the subscribers
  LinkedList<_ListenerEntry<T>>? _listeners = LinkedList<_ListenerEntry<T>>();

  /// Tell us if the controller was disposed
  bool get disposed => _listeners == null;

  bool get hasListeners => !disposed ? _listeners!.isNotEmpty : false;

  StreamController<T>? _controller;

  Completer<void>? _isBusy;

  /// A broadcast stream representation of a [StateNotifier].
  Stream<T> get stream {
    _controller ??= StreamController<T>.broadcast();
    return _controller!.stream;
  }

  /// check if the controller is mounted
  void _debugAssertNotDisposed() {
    assert(_listeners != null, 'A $runtimeType was used after being disposed.');
  }

  /// add a new listener
  void addListener(ListenerCallback<T> listener, [autoDispose = false]) {
    _debugAssertNotDisposed();
    _listeners!.add(_ListenerEntry<T>(listener, autoDispose));
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

  _complete() {
    if (_isBusy != null && !_isBusy!.isCompleted) {
      _isBusy!.complete();
    }
  }

  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  @protected
  void notifyListeners(T data) {
    _debugAssertNotDisposed();

    _isBusy = Completer();

    if (_listeners!.isNotEmpty) {
      if (_controller != null && !_controller!.isClosed) {
        _controller?.sink.add(data);
      }
      for (final _ListenerEntry<T> entry in _listeners!) {
        if (entry.list != null) entry.listener(data);
      }
    }
    _complete();
  }

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  void onInit();

  /// when the MeeduBuilder was mounted
  void onAfterFirstLayout();

  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  void onDispose() async {
    _debugAssertNotDisposed();

    _controller?.close();
    if (_isBusy != null) {
      await _isBusy!.future;
    }
    _listeners!.clear();
    _listeners = null;
  }
}
