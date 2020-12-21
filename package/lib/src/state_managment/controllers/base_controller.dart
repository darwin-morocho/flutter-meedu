import 'dart:async';
import 'package:flutter/foundation.dart';

class BaseListener<T> {
  final void Function(T) listener;
  BaseListener(this.listener);
}

abstract class BaseController<T> {
  bool _disposed = false, _initialized = false;

  List<BaseListener<T>> _listeners = [];
  bool get disposed => _disposed;
  bool get initialized => _initialized;

  void addListener(BaseListener listener) {
    _listeners.add(listener);
  }

  void removeListener(BaseListener listener) {
    _listeners.remove(listener);
  }

  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void notify([T data]) {
    if (!_disposed) {
      _listeners.forEach((e) {
        e.listener(data);
      });
    }
  }

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  @mustCallSuper
  void onInit() {
    _initialized = true;
  }

  /// when the MeeduBuilder was mounted
  void afterFirstLayout();

  /// use to listen when the controller was deleted from memory
  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  Future<void> onDispose() async {
    _disposed = true;
    _listeners.clear();
    _listeners = null;
  }
}
