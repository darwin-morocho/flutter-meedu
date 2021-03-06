import 'base_notifier.dart';
import 'package:meta/meta.dart' show mustCallSuper;

abstract class SimpleNotifier extends BaseNotifier<List<String>> {
  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  @override
  void notify([List<String> listeners = const []]) {
    super.notify(listeners);
  }

  /// use to listen when the controller was deleted from memory
  @override
  @mustCallSuper
  void dispose() async {
    super.dispose();
  }
}
