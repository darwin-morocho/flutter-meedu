import 'dart:async';

import 'package:flutter/foundation.dart' show mustCallSuper;

abstract class BaseController<T> {
  bool _disposed = false;
  bool get disposed => _disposed;

  StreamController<T> _streamController = StreamController.broadcast();
  Stream<T> get stream => _streamController.stream;

  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void notify([T data]) {
    assert(data != null);
    if (!_disposed) {
      _streamController.sink.add(data);
    }
  }

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  void onInit();

  /// when the MeeduBuilder was mounted
  void afterFirstLayout();

  /// use to listen when the controller was deleted from memory
  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  Future<void> onDispose() async {
    _disposed = true;
    await _streamController.close();
  }
}
