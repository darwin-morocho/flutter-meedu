import 'package:flutter_meedu/notifiers.dart';

class CounterBloc extends Bloc<Increment, int> {
  CounterBloc(super.initialState) {
    on<Increment>(
      (event, emit) => emit(state + 1),
    );
  }
}

abstract class CounterEvent {}
class Increment extends CounterEvent {}
