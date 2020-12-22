import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_state.dart';

class GetXExample extends StatelessWidget {
  const GetXExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Builder(
            builder: (_) {
              final controller = Get.find<LoginController>();
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
                  GetBuilder<LoginController>(
                    id: 'email',
                    builder: (_) => Text("email is ${_.state.email}"),
                  ),
                  GetBuilder<LoginController>(
                    id: 'password',
                    builder: (_) => Text("password is ${_.state.password}"),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoginController extends GetxController {
  LoginState state = LoginState.initialState;

  void onEmailChanged(String email) {
    state = this.state.copyWith(email: email);
    update(['email']);
  }

  void onPasswordChanged(String password) {
    state = this.state.copyWith(password: password);
    update(['password']);
  }
}
