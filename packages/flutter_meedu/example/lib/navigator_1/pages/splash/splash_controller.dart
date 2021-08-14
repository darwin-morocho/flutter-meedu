import 'package:flutter_meedu/meedu.dart';
import 'package:meedu_example/navigator_1/routes/routes.dart';

class SplashController extends SimpleNotifier {
  SplashController() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      _routeName = Routes.MENU;
      notify();
    });
  }

  String? _routeName;
  String? get routeName => _routeName;

  @override
  void dispose() {
    print("SplashController disposed");
    super.dispose();
  }
}
