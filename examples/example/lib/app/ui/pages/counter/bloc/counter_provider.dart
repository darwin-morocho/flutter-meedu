import 'package:flutter_meedu/meedu.dart';
import 'counter_bloc.dart';

final counterProvider = StateProvider<CounterBloc, int>(
  (_) => CounterBloc(0),
);
