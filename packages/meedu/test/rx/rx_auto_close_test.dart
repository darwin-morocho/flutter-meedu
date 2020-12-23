import 'package:meedu/meedu.dart';
import 'package:test/test.dart';

void main() {
  test("auto close Rx inside a BaseController", () {
    final c = Controller();
    expect(c.counter.value, 0);
    c.onDispose();
  });
}

class Controller extends SimpleController {
  Rx<int> counter = 0.obs;

  @override
  Future<void> onDispose() {
    return super.onDispose();
  }
}
