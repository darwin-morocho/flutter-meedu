import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';

final colorProvider = Provider.stateArgumentsTag<ColorNotifier, int, int>(
  (ref) => ColorNotifier(ref.arguments),
);

class ColorNotifier extends StateNotifier<int> {
  ColorNotifier(super.initialState);
}
