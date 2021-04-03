import 'package:meedu/state.dart';

class HomeController extends SimpleNotifier {
  int counter = 0;

  @override
  void onInit() {
    print("onInit");
  }

  @override
  void onAfterFirstLayout() {
    print("afterFirstLayout");
  }

  void increment() {
    counter++;
    update(['counter']);
  }

  @override
  void onDispose() {
    super.onDispose();
  }
}
