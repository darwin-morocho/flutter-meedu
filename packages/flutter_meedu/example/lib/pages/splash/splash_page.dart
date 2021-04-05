import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu_example/pages/splash/splash_controller.dart';
import 'package:meedu_example/pages/splash/splash_provider.dart';
import 'package:flutter_meedu/router.dart' as router;

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashController>(
      onChanged: (_) {
        if (_.routeName != null) {
          print(_.routeName);
          router.pushReplacementNamed(_.routeName!);
        }
      },
      provider: splashProvider,
      builder: (_, __) => Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
