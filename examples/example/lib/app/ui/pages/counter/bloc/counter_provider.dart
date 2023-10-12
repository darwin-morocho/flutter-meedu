import 'package:flutter_meedu/providers.dart';

import 'counter_bloc.dart';

final counterProvider = StateNotifierProvider<CounterBloc, int>(
  (_) => CounterBloc(0),
);
