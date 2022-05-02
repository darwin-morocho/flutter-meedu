import 'package:example/app/ui/pages/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'controller/splash_provider.dart';
import 'package:flutter_meedu/ui.dart';

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
