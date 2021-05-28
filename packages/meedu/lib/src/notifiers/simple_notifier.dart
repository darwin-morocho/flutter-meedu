import 'base_notifier.dart';
import 'package:meta/meta.dart' show mustCallSuper;

abstract class SimpleNotifier extends BaseNotifier<List<String>> {
  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void notify([List<String> listeners = const []]) {
    super.notify(listeners);
  }

  /// Called when this object is inserted into the tree using a [Provider].
  @override
  void onInit() {}

  /// when the Provider widget was redered once
  @override
  void onAfterFirstLayout() {}

  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  void onDispose() async {
    super.onDispose();
  }
}
