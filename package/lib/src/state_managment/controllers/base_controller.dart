import 'dart:async';
import 'dart:collection' show LinkedList, LinkedListEntry;
import 'package:flutter/foundation.dart';

class _ListenerEntry extends LinkedListEntry<_ListenerEntry> {
  _ListenerEntry(this.listener);
  final VoidCallback listener;
}

abstract class BaseController<T> implements Listenable {
  LinkedList<_ListenerEntry> _listeners = LinkedList<_ListenerEntry>();

  bool _disposed = false, _initialized = false;
  bool get disposed => _disposed;
  bool get initialized => _initialized;

  T _data;
  T get data => _data;

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_disposed) {
        throw FlutterError('A $runtimeType was used after being disposed.');
      }
      return true;
    }());
    return true;
  }

  @override
  void addListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    _listeners.add(_ListenerEntry(listener));
  }

  bool get hasListeners {
    assert(_debugAssertNotDisposed());
    return _listeners.isNotEmpty;
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    for (final _ListenerEntry entry in _listeners) {
      if (entry.listener == listener) {
        entry.unlink();
        return;
      }
    }
  }

  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void notify([T data]) {
    try {
      if (!_disposed) {
        _data = data;
        for (final _ListenerEntry entry in _listeners) {
          if (entry.list != null) {
            entry.listener();
            return;
          }
        }
      }
    } catch (e, s) {
      print(e);
      print(s);
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
