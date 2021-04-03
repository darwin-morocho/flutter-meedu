part of 'rx.dart';

/// class to add dynamic updates into a RxBuilder widget
@sealed
class RxNotifier<T> {
  Rx<T?> subject = Rx(null);
  static RxNotifier? proxy;
  final Map<Rx, List<StreamSubscription>> _subscriptions = {};
  Map<Rx, List<StreamSubscription>> get subscriptions => _subscriptions;

  bool get canUpdate => _subscriptions.isNotEmpty;

  void addListener(Rx<T> rx) {
    if (!_subscriptions.containsKey(rx)) {
      final StreamSubscription subs = rx.stream.listen(subject.controller.add);

      /// ge the subscriptions for this Rx
      final List<StreamSubscription> listSubscriptions = _subscriptions[rx] ?? [];
      listSubscriptions.add(subs);
      _subscriptions[rx] = listSubscriptions;
    }
  }

  StreamSubscription<T?> listen(void Function(T?) _) => subject.stream.listen(_);

  /// Closes the subscriptions for this Rx, releasing the resources.
  void close() {
    _subscriptions.forEach((_, _subscriptions) {
      for (final subscription in _subscriptions) {
        subscription.cancel();
      }
    });
    _subscriptions.clear();
    subject.close();
  }
}
