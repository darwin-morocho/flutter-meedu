import 'package:flutter_meedu/flutter_meedu.dart';

class ColorController extends SimpleNotifier {
  final int color;
  ColorController(this.color);

  @override
  void dispose() {
    print("disposed color $color");
    super.dispose();
  }
}

final colorProvider = SimpleProvider.withTag(
  (ref) => ColorController(ref.arguments),
);
