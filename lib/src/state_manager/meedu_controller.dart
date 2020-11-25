import 'dart:async';

import 'package:meta/meta.dart' show mustCallSuper;
import 'package:meedu/src/state_manager/life_cycle_base.dart';

abstract class MController implements LifeCycleBase {
  /// boolean to check if the controller is linked with a mounted widget
  bool _disposed = false;
  bool get disposed => _disposed;

  StreamController<List<String>> _streamController = StreamController.broadcast();

  /// Stream to allow changes
  Stream<List<String>> get stream => _streamController.stream;

  /// notify to listeners and rebuild the widgets
  ///
  /// [state] the new state of the controller
  ///
  /// [listeners] a list of strings to update the widgets (MBuilder) with the ids inside the list
  void update([List<String> listeners = const []]) {
    assert(listeners != null);
    if (!_disposed) {
      _streamController.sink.add(listeners);
    }
  }

  /// when the MeeduBuilder was mounted
  @override
  void afterFirstLayout() {}

  /// use to listen when the controller was deleted from memory
  @override
  @mustCallSuper
  FutureOr<void> onClose() async {
    _disposed = true;
    await _streamController.close();
  }

  @override
  void onInit() {}
}
