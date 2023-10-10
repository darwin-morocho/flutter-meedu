// ignore_for_file: hash_and_equals

import 'dart:async';

import 'package:meta/meta.dart';

typedef ListenerCallback<T> = void Function(T);

/// Define a base notifier for SimpleNotifier and StateNotifier
abstract class BaseNotifier<S> {
  /// used to check if a notifier was disposed
  bool _disposed = false;

  /// Tell us if the notifier was disposed
  bool get disposed => _disposed;

  /// Tell us if the notifier is mounted
  bool get mounted => !_disposed;

  @mustCallSuper
  FutureOr<void> dispose() {
    _disposed = true;
  }

  // Custom implementation of hash code optimized for reading notifiers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}

mixin ListeneableNotifier<T> {
  final _listeners = <ListenerCallback<T>>[];

  /// completer to check if we are emiting events before call dispose
  Completer<void>? _isBusy;

  /// returns true when the current notifier has subscribers
  bool get hasListeners => _listeners.isNotEmpty;

  void Function()? _disposableCallback;

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
    if (_listeners.isNotEmpty) {
      for (final entry in _listeners) {
        entry(data);
      }
    }
    _complete();
  }

  /// add a new listener
  void addListener(ListenerCallback<T> listener) {
    _listeners.add(listener);
  }

  /// remove a listener from the notifier
  void removeListener(ListenerCallback<T> listener) {
    if (_listeners.isNotEmpty) {
      _listeners.remove(listener);

      if (!hasListeners) {
        _disposableCallback?.call();
      }
    }
  }

  @protected
  Future<void> clearListeners() async {
    await _isBusy?.future;
    _listeners.clear();
  }

  @protected
  void setDisposableCallback(void Function() disposableCallback) {
    _disposableCallback = disposableCallback;
  }
}
