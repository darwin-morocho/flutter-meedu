import 'dart:async';

import 'package:flutter/foundation.dart' show ChangeNotifier, VoidCallback, mustCallSuper;

abstract class BaseController<T> extends ChangeNotifier {
  bool _disposed = false;
  bool get disposed => _disposed;

  T _data;
  T get data => _data;

  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void notify([T data]) {
    if (!_disposed) {
      _data = data;
      notifyListeners();
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
    if (super.hasListeners) {
      super.dispose();
    }
  }
}
