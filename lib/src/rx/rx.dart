import 'dart:async';

/// Rx class to work with observables
class Rx<T> {
  T _value;
  T get value => _value;
  StreamController<T> _controller = StreamController.broadcast();
  Stream<T> get stream => _controller.stream;

  /// Constructor
  ///
  /// creates a new observable with an initial value
  Rx(T initalValue) {
    _value = initalValue;
  }

  /// update the value and add a event sink to the [StreamController]
  set value(T newValue) {
    _value = newValue;
    _controller.sink.add(_value);
  }

  /// close the [StreamController] for this observable
  Future<void> close() => _controller.close();
}
