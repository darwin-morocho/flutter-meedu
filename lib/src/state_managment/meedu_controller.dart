import 'dart:async';
import 'package:flutter/foundation.dart' show mustCallSuper;

abstract class MeeduController {
  /// boolean to check if the controller is linked with a mounted widget
  bool _disposed = false;
  bool get disposed => _disposed;

  StreamController<List<String>> _streaMeeduController = StreamController.broadcast();

  /// Stream to allow changes
  Stream<List<String>> get stream => _streaMeeduController.stream;

  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void update([List<String> listeners = const []]) {
    assert(listeners != null);
    if (!_disposed) {
      _streaMeeduController.sink.add(listeners);
    }
  }

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  void onInit() {}

  /// when the MeeduBuilder was mounted
  void afterFirstLayout() {}

  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  Future<void> onDispose() async {
    _disposed = true;
    await _streaMeeduController.close();
  }
}
