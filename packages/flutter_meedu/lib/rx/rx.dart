import 'dart:async';

import 'package:meta/meta.dart' show sealed;

part 'rx_notifier.dart';

/// Rx class to work with observables
class Rx<T> {

  /// Constructor
  ///
  /// creates a new observable with an initial value
  Rx(T initalValue) {
    _value = initalValue;
  }
  /// store the value for this observable
  late T _value;

  /// StreamController to emit the changes in the current observable
  StreamController<T>? _controller;

  StreamController<T> get controller {
    _controller ??= StreamController.broadcast();
    return _controller!;
  }

  /// stream for the current observable
  Stream<T> get stream => controller.stream;

  /// returns true if the current observable has listeners
  bool get hasListeners => controller.hasListener;

  /// update the value and add a event sink to the [StreamController]
  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      controller.sink.add(_value);
    }
  }

  /// returns the current value for this observable
  T get value {
    // if we have a RxBuilder accessing to the current value
    // we add a listener for that Widget
    if (RxNotifier.proxy != null) {
      RxNotifier.proxy!.addListener(this);
    }
    return _value;
  }

  /// close the [StreaMeeduController] for this observable
  FutureOr<void> close() => _controller?.close();
}
