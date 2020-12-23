import 'dart:async';
import 'rx.dart';

extension RxExtensions<T> on Rx<T> {
  /// [callback] is called every time that the [Rx<T>] changes.
  ///
  /// If [condition] is not null the [callback] only is called if [condition] returns true.
  RxUtil ever(void Function(T) callback, {bool Function(T) condition}) {
    // ignore: cancel_subscriptions
    final StreamSubscription subscription = this.stream.listen((event) {
      if (condition != null) {
        if (condition(event)) {
          callback(event);
        }
      } else {
        callback(event);
      }
    });
    return RxUtil(subscription, null);
  }

  /// the [callback] will be executed only 1 time
  ///
  /// If [condition] is not null the [callback] only is called if [condition] returns true.
  RxUtil once(void Function(T) callback, {bool Function(T) condition}) {
    RxUtil rxUtil;
    // ignore: cancel_subscriptions
    StreamSubscription subscription = this.stream.listen((event) {
      if (condition != null) {
        if (condition(event)) {
          callback(event);
          rxUtil.dispose();
        }
      } else {
        callback(event);
        rxUtil.dispose();
      }
    });
    rxUtil = RxUtil(subscription, null);
    return rxUtil;
  }

  /// the [callback] will be called every certain time interval ignoring the other changes
  RxUtil interval(Duration duration, void Function(T) callback) {
    Debouncer debouncer = Debouncer(duration);
    // ignore: cancel_subscriptions
    final StreamSubscription subscription = this.stream.listen((event) {
      if (!debouncer.isRunning) {
        debouncer.call(() {
          callback(event);
          debouncer = Debouncer(duration);
        });
      }
    });
    return RxUtil(subscription, debouncer);
  }

  /// Every time that the [Rx<T>] changes the [callback] will be called after a delay.
  RxUtil debounce(Duration delay, void Function(T) callback) {
    final Debouncer debouncer = Debouncer(delay);
    // ignore: cancel_subscriptions
    final StreamSubscription subscription = this.stream.listen((event) {
      debouncer.call(() {
        callback(event);
      });
    });
    return RxUtil(subscription, debouncer);
  }
}

/// this class allow us to cancel schedules tasks and subscriptions
class RxUtil {
  final StreamSubscription _subscription;
  final Debouncer _debouncer;
  bool _disposed = false;

  RxUtil(this._subscription, this._debouncer);

  Future<void> dispose() async {
    if (_disposed) return;
    // cancel a schedule task
    _debouncer?.cancel();
    // cancel the events susbcription
    await _subscription?.cancel();
    _disposed = true;
  }
}

/// this class is an implementenacion of a debounce functionallity
class Debouncer {
  /// delay for a schedule task
  final Duration delay;

  // timer for a schedule task
  Timer _timer;

  Debouncer(this.delay);

  void call(void Function() action) {
    _timer?.cancel(); // cancel the current task
    _timer = Timer(delay, action);
  }

  /// Notifies if the delayed call is active.
  bool get isRunning => _timer?.isActive ?? false;

  /// Cancel the current delayed call.
  void cancel() => _timer?.cancel();
}
