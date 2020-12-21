import 'package:meedu/state.dart';

class HomeController extends SimpleController {
  int counter = 0;
  @override
  void onInit() {
    super.onInit();
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
