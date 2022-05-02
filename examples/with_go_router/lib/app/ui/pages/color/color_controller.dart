import 'package:flutter_meedu/meedu.dart';

class ColorController extends SimpleNotifier {
  final int color;
  ColorController(this.color);
}

final colorProvider = SimpleProvider.withTag(
  (ref) => ColorController(ref.arguments),
);
