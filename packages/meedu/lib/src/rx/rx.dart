import 'dart:async';
import 'package:meta/meta.dart' show sealed;
part 'rx_notifier.dart';

/// Rx class to work with observables
class Rx<T> {
  late T _value;
  StreamController<T> _controller = StreamController.broadcast();
  StreamController<T> get controller => _controller;

  Stream<T> get stream => _controller.stream;
  bool get hasListeners => _controller.hasListener;

  /// Constructor
  ///
  /// creates a new observable with an initial value
  Rx(T initalValue) {
    _value = initalValue;
  }

  /// update the value and add a event sink to the [StreaMeeduController]
  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _controller.sink.add(_value);
    }
  }

  T get value {
    // if we have a RxBuilder accessing to the current value
    // we add a listener for that Widget
    if (RxNotifier.proxy != null) {
      RxNotifier.proxy!.addListener(this);
    }
    return _value;
  }

  /// close the [StreaMeeduController] for this observable
  Future<void> close() => _controller.close();
}
