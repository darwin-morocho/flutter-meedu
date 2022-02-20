import 'package:meta/meta.dart' show mustCallSuper;

import 'base_notifier.dart';

abstract class SimpleNotifier extends BaseNotifier<List<String>> {
  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  @override
  void notify([
    @Deprecated(
      'This property is obsolete because it was used for `.ids`'
      ' filter but `.select` filter more efficient so this property will be removed'
      ' in meedu:^5.x.x and flutter_meedu:^6.x.x',
    )
        List<String> listeners = const [],
  ]) {
    super.notify(listeners);
  }

  /// use to listen when the controller was deleted from memory
  @override
  @mustCallSuper
  void dispose() async {
    super.dispose();
  }
}
