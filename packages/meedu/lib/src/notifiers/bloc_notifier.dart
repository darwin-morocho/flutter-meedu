import 'dart:async';
import 'package:meta/meta.dart';

import 'state_notifier.dart';

/// A class to allow us implement the BLoC pattern
abstract class Bloc<Event, State> extends StateNotifier<State> {
  Bloc(super.initialState);

  final _handlers = <Type, Function>{};

  /// Register an event handler for an event of type `E`.
  /// There should only ever be one event handler per event type `E`.
  void on<E extends Event>(
    _Handler<E, State> handler,
  ) {
    _handlers.putIfAbsent(
      E,
      () => handler,
    );
  }

  /// Notifies the [Bloc] of a new [event] which triggers
  /// all corresponding handlers.
  ///
  /// * An [AssertionError] will be thrown if there is no event handler
  /// registered for the incoming [event].
  void add<E extends Event>(E event) {
    assert(
      _handlers.containsKey(E),
      'on<${E.runtimeType}>(...) must be called before add(${E.runtimeType})',
    );

    final handler = _handlers[E] as _Handler<E, State>;
    final emitter = Emitter<State>(
      (newState) => state = newState,
    );

    final result = handler(event, emitter);

    /// disable the emitter after handler has been completed
    if (result is Future) {
      result.then(
        (_) => emitter._disable(),
      );
    } else {
      emitter._disable();
    }
  }

  @visibleForTesting
  @override
  set state(State newState) => super.state = newState;
}

typedef _Handler<E, State> = FutureOr<void> Function(
  E event,
  Emitter<State> emit,
);

/// An [Emitter] is a class which is capable of emitting new states.
class Emitter<State> {
  Emitter(this._updater);
  final void Function(State newState) _updater;

  bool _enabled = true;

  void call(State newState) {
    assert(
      _enabled,
      '''\n\n
emit was called after an event handler completed normally.
This is usually due to an unawaited future in an event handler.
  **BAD**
  on<Event>((event, emit) {
    future.whenComplete(() => emit(...));
  });
  **GOOD**
  on<Event>((event, emit) async {
    await future.whenComplete(() => emit(...));
  });
''',
    );
    _updater(newState);
  }

  void _disable() {
    _enabled = false;
  }
}
