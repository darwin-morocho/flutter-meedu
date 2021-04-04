import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import '../../main.dart';
import 'login_state.dart';
import 'login_controller.dart';
import 'package:flutter_meedu/flutter_meedu.dart' show Provider, StateWidget, StateBuilder;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginController>(
      create: (_) => LoginController(),
      tag: 'login',
      builder: (_, __) => Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Builder(
            builder: (_) {
              final controller = Provider.of<LoginController>(tag: 'login');
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleBuilder<AppThemeController>(
                    builder: (_) => Text("_.darkMode ${_.darkMode}"),
                  ),
                  CupertinoTextField(
                    onChanged: controller.onEmailChanged,
                    placeholder: "email",
                  ),
                  SizedBox(height: 20),
                  CupertinoTextField(
                    onChanged: controller.onPasswordChanged,
                    placeholder: "password",
                  ),
                  SizedBox(height: 20),
                  StateBuilder<LoginController, LoginState>(
                    tag: 'login',
                    builder: (_) => Text("email is ${_.state.email}"),
                  ),
                  StateBuilder<LoginController, LoginState>(
                    tag: 'login',
                    buildWhen: (oldState, newState) => oldState.password != newState.password,
                    builder: (_) => Text("password is ${_.state.password}"),
                  ),
                  LoginDetail(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoginDetail extends StateWidget<LoginController, LoginState> {
  @override
  String get tag => 'login';

  @override
  get buildWhen => (prevState, currentState) {
        return prevState != currentState;
      };

  @override
  Widget buildChild(BuildContext context, LoginController controller) {
    final email = controller.state.email;
    final password = controller.state.password;
    return Column(
      children: [
        SizedBox(height: 20),
        Text(":::StateWidget:::"),
        Text("Email: $email"),
        Text("Password: $password"),
      ],
    );
  }
}
