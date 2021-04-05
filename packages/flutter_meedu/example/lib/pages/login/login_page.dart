import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu_example/pages/login/login_controller.dart';
import 'package:meedu_example/pages/login/login_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<LoginController>(
      onChanged: (_) {},
      provider: loginProvider,
      builder: (_, __) => Scaffold(),
    );
  }
}
