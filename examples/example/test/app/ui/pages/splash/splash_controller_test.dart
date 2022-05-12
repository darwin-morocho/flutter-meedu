import 'package:example/app/ui/pages/splash/controller/splash_controller.dart';
import 'package:example/app/ui/routes/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'SplashController',
    () async {
      final controller = SplashController();
      await controller.init();
      expect(controller.routeName, Routes.HOME);
    },
  );
}
