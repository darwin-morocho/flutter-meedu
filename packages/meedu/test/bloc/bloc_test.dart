import 'dart:async';

import 'package:meedu/src/notifiers/bloc_notifier.dart';
import 'package:test/test.dart';

import '../instance_manager/get_test.dart';

void main() {
  test(
    'Bloc',
    () {
      final bloc = _MyBloc(0);
      expect(bloc.state, 0);
      bloc.add(_Increment());
      expect(bloc.state, 1);
      bloc.add(_Decrement());
      expect(bloc.state, 0);
    },
  );

  test(
    'Bloc > Unregistered events',
    () {
      final bloc = _UnregisteredBloc(0);
      expect(bloc.state, 0);

      expect(
        () => bloc.add(_Increment()),
        throwsAssertionError,
      );
    },
  );

  test(
    'Bloc > Emitter Disabled',
    () async {
      Object? blocError;
      await runZonedGuarded(
        () async {
          final bloc = _DisabledEmitBloc(0);
          expect(bloc.state, 0);

          bloc.add(
            _Increment(),
          );
          await Future.delayed(
            Duration(milliseconds: 150),
          );
        },
        (error, stack) => blocError = error,
      );
      expect(
        blocError,
        isA<AssertionError>().having(
          (e) => e.message,
          'message',
          contains(
            'emit was called after an event handler completed normally.',
          ),
        ),
      );
    },
  );
}

class _MyBloc extends Bloc<_Event, int> {
  _MyBloc(super.initialState) {
    on<_Increment>(
      (event, emit) => emit(state + 1),
    );

    on<_Decrement>(
      (event, emit) => emit(state - 1),
    );
  }
}

class _UnregisteredBloc extends Bloc<_Event, int> {
  _UnregisteredBloc(super.initialState);
}

class _DisabledEmitBloc extends Bloc<_Event, int> {
  _DisabledEmitBloc(super.initialState) {
    on<_Increment>(_onIncrement);
  }

  Future<void> _onIncrement(_Increment _, Emitter<int> emit) async {
    await Future.delayed(
      Duration(milliseconds: 0),
    );
    emit(state + 1);
    // ignore: unawaited_futures
    Future.delayed(
      Duration(milliseconds: 50),
    ).then(
      (_) => emit(state + 1),
    );
  }
}

abstract class _Event {}

class _Increment extends _Event {}

class _Decrement extends _Event {}
