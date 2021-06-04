import 'package:flutter_meedu/meedu.dart';
import 'package:meedu_example/routes/routes.dart';

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
  void onDispose() {
    print("SplashController disposed");
    super.onDispose();
  }
}
