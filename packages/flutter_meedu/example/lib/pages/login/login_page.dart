import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/state.dart';
import 'package:meedu_example/routes/routes.dart';
import 'login_controller.dart';
import 'login_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = loginProvider.read;
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
                  router.pushNamed(
                    Routes.HOME,
                    arguments: DateTime.now(),
                  );
                  // final route = MaterialPageRoute(builder: (_) => HomePage());
                  // Navigator.push(context, route);
                },
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                color: Colors.blue,
                child: Text("GO TO TABS"),
                onPressed: () async {
                  router.pushNamed(Routes.TABS);
                },
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                color: Colors.blue,
                child: Text("GO TO VIDEO PAGE"),
                onPressed: () async {
                  router.pushNamed(Routes.VIDEO);
                },
              ),
              Consumer(builder: (_, watch, ___) {
                print("email");
                final email = watch<LoginController, String>(
                  loginProvider,
                  WatchFilter(select: (_) => _.email),
                ).email;
                return Text(email);
              }),
              Consumer(builder: (_, watch, ___) {
                print("password");
                final password = watch<LoginController, String>(
                  loginProvider,
                  WatchFilter(select: (_) => _.password),
                ).password;
                return Text(password);
              }),
              Consumer(builder: (_, watch, ___) {
                print("password by id");
                final password = watch(
                  loginProvider,
                  WatchFilter(ids: ['password']),
                ).password;
                return Text("password by Id $password");
              }),
              Consumer(builder: (_, watch, ___) {
                print("email by id");
                final email = watch(
                  loginProvider,
                  WatchFilter(ids: ['email']),
                ).email;
                return Text("email by Id $email");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
