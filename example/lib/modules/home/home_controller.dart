import 'package:meedu/state.dart';

class HomeController extends MController {
  int counter = 0;
  @override
  void onInit() {
    print("onInit");
  }

  @override
  void afterFirstLayout() {
    print("afterFirstLayout");
  }

  void incremment() {
    counter++;
    update(['counter']);
  }

  @override
  Future<void> onDispose() {
    return super.onDispose();
  }
}
