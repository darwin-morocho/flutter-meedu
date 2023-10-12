import 'package:flutter_meedu/notifiers.dart';

import '../../../routes/routes.dart';

class SplashNotifier extends StateNotifier<String?> {
  SplashNotifier(super.initialState);

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));
    state = Routes.HOME;
  }
}
