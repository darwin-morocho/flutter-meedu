import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';

final colorProvider = StateNotifierArgumentsProvider<ColorNotifier, int, int>(
  (ref) => ColorNotifier(ref.arguments),
);

class ColorNotifier extends StateNotifier<int> {
  ColorNotifier(super.initialState);
}
