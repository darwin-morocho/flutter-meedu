import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart' show mustCallSuper, protected;
import 'type.dart';

/// Define a base notifier for SimpleNotifier and StateNotifier
abstract class BaseNotifier<T> {
  /// used to check if a notifier was disposed
  bool _disposed = false;

  /// Tell us if the controller was disposed
  bool get disposed => _disposed;

  /// check if the controller is mounted
  @protected
  void debugAssertNotDisposed() {
    assert(!_disposed, 'A $runtimeType was used after being disposed.');
  }

  @mustCallSuper
  void dispose() {
    _disposed = true;
  }

  // Custom implementation of hash code optimized for reading notifiers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}

mixin ListeneableNotifier<T> {
  final _listeners = LinkedList<ListenerEntry<T>>();

  /// StreamController to allow us listen the notify events as a Stream
  StreamController<T>? _controller;

  /// completer to check if we are emiting events before call dispose
  Completer<void>? _isBusy;

  /// returns true when the current notifier has subscribers
  bool get hasListeners => _listeners.isNotEmpty;

  /// A broadcast stream representation of a [StateNotifier].
  Stream<T> get stream {
    _controller ??= StreamController<T>.broadcast();
    return _controller!.stream;
  }

  void _complete() {
    if (_isBusy != null && !_isBusy!.isCompleted) {
      _isBusy!.complete();
    }
  }

  /// notify to listeners and rebuild the widgets
  ///
  /// only SimpleNotifier or StateNotifier are allowed to call this method, DON'T  call to this method since
  /// a sub-type of SimpleNotifier or StateNotifier
  void notifyListeners(T data) {
    _isBusy = Completer();
    if (_controller != null && !_controller!.isClosed) {
      _controller?.sink.add(data);
    }
    if (_listeners.isNotEmpty) {
      for (final entry in _listeners) {
        if (entry.list != null) entry.listener(data);
      }
    }
    _complete();
  }

  /// add a new listener
  void addListener(ListenerCallback<T> listener) {
    _listeners.add(
      ListenerEntry(listener),
    );
  }

  /// remove a listener from the notifier
  void removeListener(ListenerCallback<T> listener) {
    if (_listeners.isNotEmpty) {
      for (final entry in _listeners) {
        if (entry.listener == listener) {
          entry.unlink();
          return;
        }
      }
    }
  }

  @protected
  Future<void> clearListeners() async {
    // ignore: unawaited_futures
    _controller?.close();
    if (_isBusy != null) {
      await _isBusy!.future;
    }
    _listeners.clear();
  }
}
