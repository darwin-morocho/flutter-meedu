import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'splash_controller.dart';
import 'splash_provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashController>(
      onChange: (context, _) {
        if (_.routeName != null) {
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
