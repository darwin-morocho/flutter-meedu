import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_state.dart';
import 'login_controller.dart';
import 'package:flutter_meedu/flutter_meedu.dart' show Provider, StateWidget, StateBuilder;

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginController>(
      create: (_) => LoginController(),
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Builder(
            builder: (_) {
              final controller = Provider.of<LoginController>(_);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    builder: (_) => Text("email is ${_.state.email}"),
                  ),
                  StateBuilder<LoginController, LoginState>(
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
