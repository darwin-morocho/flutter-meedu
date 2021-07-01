import 'package:flutter_meedu/meedu.dart';

class HomeTabController extends SimpleNotifier {
  final counter = 0.obs;

  @override
  void dispose() {
    counter.close();
    print("HomeTabController disposed");
    super.dispose();
  }
}

final homeTabProvider = SimpleProvider(
  (_) => HomeTabController(),
);
