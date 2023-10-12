import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';

import 'controller/splash_provider.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, BuilderRef ref) {
    ref.listen(
      splashProvider,
      callback: (notifier) {
        final routeName = notifier.state;
        if (routeName != null && context.mounted) {
          Navigator.pushReplacementNamed(context, routeName);
        }
      },
    );

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
