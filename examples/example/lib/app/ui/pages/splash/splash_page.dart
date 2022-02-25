import 'package:example/app/ui/pages/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'controller/splash_provider.dart';
import 'package:flutter_meedu/router.dart' as router;

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashController>(
      provider: splashProvider,
      onAfterFirstLayout: (_, controller) => controller.init(),
      onChange: (_, controller) {
        final routeName = controller.routeName;

        if (routeName != null) {
          router.pushReplacementNamed(routeName);
        }
      },
      builder: (_, __) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
