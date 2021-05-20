import 'package:flutter_meedu/meedu.dart';

class HomeTabController extends SimpleNotifier {
  final counter = 0.obs;

  @override
  void onDispose() {
    counter.close();
    print("HomeTabController disposed");
    super.onDispose();
  }
}

final homeTabProvider = SimpleProvider(
  (_) => HomeTabController(),
);
