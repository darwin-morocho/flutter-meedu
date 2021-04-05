import 'package:meedu/meedu.dart';
import 'package:meedu_example/routes/routes.dart';

class SplashController extends SimpleNotifier {
  SplashController() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      _routeName = Routes.LOGIN;
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
