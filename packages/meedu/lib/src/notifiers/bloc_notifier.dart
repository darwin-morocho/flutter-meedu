import 'dart:async';
import 'package:meta/meta.dart';

import 'state_notifier.dart';

/// A class to allow us implement the BLoC pattern
abstract class Bloc<Event, State> extends StateNotifier<State> {
  Bloc(super.initialState);

  final _handlers = <_Handler>[];

  /// Register an event handler for an event of type `E`.
  /// There should only ever be one event handler per event type `E`.
  void on<E extends Event>(
    _HandlerFn<E, State> fn,
  ) {
    final registered = _handlers.any((handler) => handler.type == E);
    assert(
      !registered,
      'on<$E> was called multiple times.',
    );
    _handlers.add(
      _Handler(
        isType: (e) => e is E,
        type: E,
        fn: fn,
      ),
    );
  }

  /// Notifies the [Bloc] of a new [event] which triggers
  /// all corresponding handlers.
  ///
  /// * An [AssertionError] will be thrown if there is no event handler
  /// registered for the incoming [event].
  void add(Event event) {
    final index = _handlers.indexWhere((e) => e.isType(event));
    final eventType = event.runtimeType;
    assert(
      index != -1,
      'on<$eventType>(...) must be called before add($eventType)',
    );

    final fn = _handlers[index].fn;
    final emitter = Emitter<State>(
      (newState) => state = newState,
    );

    final result = fn(event, emitter) as FutureOr<void>;

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

typedef _HandlerFn<E, State> = FutureOr<void> Function(
  E event,
  Emitter<State> emit,
);

class _Handler {
  const _Handler({
    required this.isType,
    required this.type,
    required this.fn,
  });
  final bool Function(dynamic value) isType;
  final Type type;
  final Function fn;
}

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
