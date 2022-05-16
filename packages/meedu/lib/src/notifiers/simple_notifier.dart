import 'package:meta/meta.dart' show mustCallSuper;

import 'base_notifier.dart';

class SimpleNotifierEmptyData {
  const SimpleNotifierEmptyData();
}

abstract class SimpleNotifier extends BaseNotifier
    with ListeneableNotifier<SimpleNotifierEmptyData> {
  /// notify to listeners and rebuild the widgets
  void notify() {
    debugAssertNotDisposed();
    notifyListeners(
      const SimpleNotifierEmptyData(),
    );
  }

  /// use to listen when the controller was deleted from memory
  @override
  @mustCallSuper
  void dispose() async {
    super.dispose();
    await clearListeners();
  }
}
