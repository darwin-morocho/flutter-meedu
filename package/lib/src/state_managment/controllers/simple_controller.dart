import 'dart:async';
import 'package:flutter/foundation.dart' show mustCallSuper;
import 'package:meedu/src/state_managment/controllers/base_controller.dart';

abstract class SimpleController extends BaseController<List<String>> {
  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void update([List<String> listeners = const []]) {
    assert(listeners != null);
    notify(listeners);
  }

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  @override
  void onInit() {}

  /// when the MeeduBuilder was mounted
  @override
  void afterFirstLayout() {}

  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  Future<void> onDispose() async {
    super.onDispose();
  }
}
