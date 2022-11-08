import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';

typedef CounterState = State<int>;

class CounterController extends SimpleNotifier with StateMixin<int> {
  CounterController() {
    initState(
      CounterState.loading(),
    );
  }

  Future<void> initialize() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    success(100);
  }

  void increment() {
    state.mapOrNull(
      success: (value) {
        success(value + 1);
      },
    );
  }
}

mixin StateMixin<T> on SimpleNotifier {
  late State<T> _state, _oldState;

  State<T> get state => _state;
  State<T> get oldState => _oldState;

  Success<T> get successState => _state as Success<T>;
  Error<T> get errorState => _state as Error<T>;

  void initState(State<T> initialState) {
    _state = _oldState = initialState;
  }

  void _setState(State<T> newState) {
    _oldState = _state;
    _state = newState;
    notify();
  }

  Success<T> success(T data) {
    _setState(State<T>.success(data));
    return state as Success<T>;
  }

  Error<T> error(Object? error) {
    _setState(State<T>.error(error));
    return state as Error<T>;
  }

  Loading<T> loading() {
    _setState(State<T>.loading());
    return state as Loading<T>;
  }
}

abstract class State<T> {
  State();
  factory State.loading() => Loading<T>();
  factory State.error(Object? error) => Error<T>(error);
  factory State.success(T data) => Success<T>(data);

  R map<R>({
    required R Function() loading,
    required R Function(Object? data) error,
    required R Function(T data) success,
  }) {
    if (this is Loading) {
      return loading();
    }
    if (this is Error) {
      return error(
        (this as Error).error,
      );
    }

    return success(
      (this as Success).data,
    );
  }

  R? mapOrNull<R>({
    R Function()? loading,
    R Function(Object? data)? error,
    R Function(T data)? success,
  }) {
    if (this is Loading && loading != null) {
      return loading();
    }
    if (this is Error && error != null) {
      return error(
        (this as Error).error,
      );
    }
    if (success != null) {
      return success(
        (this as Success).data,
      );
    }
    return null;
  }
}

class Loading<T> extends State<T> {}

class Error<T> extends State<T> {
  final Object? error;
  Error(this.error);
}

class Success<T> extends State<T> {
  final T data;

  Success(this.data);
}

final counterProvider = SimpleProvider(
  (_) => CounterController()..initialize(),
);

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterProvider.read.increment(),
      ),
      body: Center(
        child: Consumer(
          builder: (_, ref, circularLoader) {
            final controller = ref.watch(counterProvider);
            return controller.state.map(
              loading: () => circularLoader!,
              error: (_) => const Text('error'),
              success: (data) => Text('Counter $data'),
            );
          },
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
