import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu_example/controllers/login_controller.dart';

final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: loginProvider.read.onEmailChanged,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
                onChanged: loginProvider.read.onPasswordChanged,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              SizedBox(height: 30),
              Consumer(
                builder: (_, watch, __) {
                  final email = watch<LoginController, LoginState>(
                    loginProvider,
                    WatchFilter(
                      when: (prev, current) => prev.email != current.email,
                    ),
                  ).state.email;

                  return Text(email);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}