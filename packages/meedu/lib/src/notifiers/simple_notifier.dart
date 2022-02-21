import 'package:meta/meta.dart' show mustCallSuper;

import 'base_notifier.dart';

abstract class SimpleNotifier extends BaseNotifier {
  /// notify to listeners and rebuild the widgets
  void notify() {
    notifyListeners([]);
  }

  /// use to listen when the controller was deleted from memory
  @override
  @mustCallSuper
  void dispose() async {
    super.dispose();
  }
}
