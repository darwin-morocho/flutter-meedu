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

/// Define a base notifier for SimpleNotifier and StateNotifier
abstract class BaseNotifier<T> {
  /// list to save the subscribers
  LinkedList<_ListenerEntry<T>>? _listeners = LinkedList<_ListenerEntry<T>>();

  /// used to check if a notifier was disposed
  bool _disposed = false;

  /// Tell us if the controller was disposed
  bool get disposed => _disposed;

  /// returns true when the current notifier has subscribers
  bool get hasListeners => !disposed ? _listeners!.isNotEmpty : false;

  /// StreamController to allow us listen the notify events as a Stream
  StreamController<T>? _controller;

  /// completer to check if we are emiting events before call dispose
  Completer<void>? _isBusy;

  /// A broadcast stream representation of a [StateNotifier].
  Stream<T> get stream {
    _controller ??= StreamController<T>.broadcast();
    return _controller!.stream;
  }

  /// check if the controller is mounted
  void _debugAssertNotDisposed() {
    assert(!_disposed, 'A $runtimeType was used after being disposed.');
  }

  /// add a new listener
  void addListener(ListenerCallback<T> listener, [autoDispose = false]) {
    _debugAssertNotDisposed();
    _listeners!.add(_ListenerEntry<T>(listener, autoDispose));
  }

  /// remove a listener from the notifier
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
  /// only SimpleNotifier or StateNotifier are allowed to call this method, DON'T  call to this method since
  /// a sub-type of SimpleNotifier or StateNotifier
  @protected
  void notify(T data) {
    _debugAssertNotDisposed();

    _isBusy = Completer();
    if (_controller != null && !_controller!.isClosed) {
      _controller?.sink.add(data);
    }
    if (_listeners!.isNotEmpty) {
      for (final _ListenerEntry<T> entry in _listeners!) {
        if (entry.list != null) entry.listener(data);
      }
    }
    _complete();
  }

  /// Called when this object is inserted into the tree using a [Provider].
  void onInit();

  /// when the MeeduBuilder was redered once
  void onAfterFirstLayout();

  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  void onDispose() async {
    _debugAssertNotDisposed();
    _disposed = true;
    _controller?.close();
    if (_isBusy != null) {
      await _isBusy!.future;
    }
    _listeners!.clear();
    _listeners = null;
  }
}
