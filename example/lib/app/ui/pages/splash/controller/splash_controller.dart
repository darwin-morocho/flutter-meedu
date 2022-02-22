import 'package:flutter_meedu/meedu.dart';

import '../../../routes/routes.dart';

class SplashController extends SimpleNotifier {
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));
    _routeName = Routes.HOME;
    notify();
  }

  String? _routeName;

  String? get routeName => _routeName;
}
