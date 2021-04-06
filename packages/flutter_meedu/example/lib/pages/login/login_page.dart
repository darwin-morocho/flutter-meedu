import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:meedu_example/routes/routes.dart';
import 'login_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = loginProvider.setArguments("HOLA MUNDO");
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: "email",
                onChanged: controller.onEmailChanged,
              ),
              SizedBox(height: 20),
              CupertinoTextField(
                placeholder: "password",
                onChanged: controller.onPasswordChanged,
              ),
              SizedBox(height: 20),
              CupertinoButton(
                color: Colors.blue,
                child: Text("SEND"),
                onPressed: () async {
                  await controller.submit();
                  router.pushNamed(Routes.HOME);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
