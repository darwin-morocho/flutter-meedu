import 'dart:async';

import 'rx.dart';

extension RxExtensions<T> on Rx<T> {
  /// [callback] is called every time that the [Rx<T>] changes.
  ///
  /// If [condition] is not null the [callback] only is called if [condition] returns true.
  RxReaction ever(void Function(T) callback, {bool Function(T)? condition}) {
    // ignore: cancel_subscriptions
    final StreamSubscription subscription = stream.listen((event) {
      if (condition != null) {
        if (condition(event)) {
          callback(event);
        }
      } else {
        callback(event);
      }
    });
    return RxReaction(subscription, null);
  }

  /// the [callback] will be executed only 1 time
  ///
  /// If [condition] is not null the [callback] only is called if [condition] returns true.
  RxReaction once(void Function(T) callback, {bool Function(T)? condition}) {
    late RxReaction reaction;
    // ignore: cancel_subscriptions
    StreamSubscription subscription = stream.listen((event) {
      if (condition != null) {
        if (condition(event)) {
          callback(event);
          reaction.dispose();
        }
      } else {
        callback(event);
        reaction.dispose();
      }
    });
    return reaction = RxReaction(subscription, null);
  }

  /// the [callback] will be called every certain time interval ignoring the other changes
  RxReaction interval(Duration duration, void Function(T) callback) {
    var debouncer = Debouncer(duration);
    // ignore: cancel_subscriptions
    final StreamSubscription subscription = stream.listen((event) {
      if (!debouncer.isRunning) {
        debouncer.call(() {
          callback(event);
          debouncer = Debouncer(duration);
        });
      }
    });
    return RxReaction(subscription, debouncer);
  }

  /// Every time that the [Rx<T>] changes the [callback] will be called after a delay.
  RxReaction debounce(Duration delay, void Function(T) callback) {
    final debouncer = Debouncer(delay);
    // ignore: cancel_subscriptions
    final StreamSubscription subscription = stream.listen((event) {
      debouncer.call(() {
        callback(event);
      });
    });
    return RxReaction(subscription, debouncer);
  }
}

/// this class allow us to cancel schedules tasks and subscriptions
class RxReaction {
  RxReaction(this._subscription, this._debouncer);

  final StreamSubscription _subscription;
  final Debouncer? _debouncer;
  bool _disposed = false;

  Future<void> dispose() async {
    if (_disposed) return;
    // cancel a schedule task
    _debouncer?.cancel();
    // cancel the events susbcription
    await _subscription.cancel();
    _disposed = true;
  }
}

/// this class is an implementenacion of a debounce functionallity
class Debouncer {
  Debouncer(this.delay);

  /// delay for a schedule task
  final Duration delay;

  // timer for a schedule task
  Timer? _timer;

  void call(void Function() action) {
    _timer?.cancel(); // cancel the current task
    _timer = Timer(delay, action);
  }

  /// Notifies if the delayed call is active.
  bool get isRunning => _timer?.isActive ?? false;

  /// Cancel the current delayed call.
  void cancel() => _timer?.cancel();
}
