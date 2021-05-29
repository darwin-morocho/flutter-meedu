part of 'rx.dart';

/// class to add dynamic updates into a RxBuilder widget
@sealed
class RxNotifier<T> {
  // observable to listen the events from other observable localled in a RxBuilder Widget
  Rx<T?> subject = Rx(null);

  /// used to create a tmp RxNotifier since a RxBuilder Widget
  static RxNotifier? proxy;

  /// store the subscriptions for one observable
  final Map<Rx, List<StreamSubscription>> _subscriptions = {};
  Map<Rx, List<StreamSubscription>> get subscriptions => _subscriptions;

  // used by the RxBuilder to check if the builder method contains an observable
  bool get canUpdate => subscriptions.isNotEmpty;

  void addListener(Rx<T> rx) {
    // if the current observable is not in the subscriptions
    if (!_subscriptions.containsKey(rx)) {
      // create a Subscription for this observable
      final StreamSubscription subs = rx.stream.listen(subject.controller.add);

      /// get the subscriptions for this Rx and add the new subscription
      final List<StreamSubscription> listSubscriptions =
          _subscriptions[rx] ?? [];
      listSubscriptions.add(subs);
      _subscriptions[rx] = listSubscriptions;
    }
  }

  /// used by the RxBuilder to listen the changes in a observable
  StreamSubscription<T?> listen(void Function(T?) _) {
    return subject.stream.listen(_);
  }

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
