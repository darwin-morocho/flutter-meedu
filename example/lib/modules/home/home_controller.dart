import 'package:meedu/meedu.dart';

class HomeController extends MeeduController {
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
  onClose() {
    print("onClose");
    super.onClose();
  }
}
