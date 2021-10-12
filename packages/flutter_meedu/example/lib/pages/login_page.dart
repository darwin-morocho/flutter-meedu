import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu_example/controllers/login_controller.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:meedu_example/routes/routes.dart';

final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
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
                    builder: (_, ref, __) {
                      final email = ref.select(
                        loginProvider.select(
                          (_) => _.email,
                        ),
                      );
                      return Text(email);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () => loginProvider.read.submit(),
                    // onPressed: () => router.pushNamed(Routes.HOME),
                    child: Text("SIGN IN"),
                  )
                ],
              ),
              Consumer(
                builder: (_, ref, __) {
                  final loading = ref
                      .watch(
                        loginProvider.when(
                          (prev, next) => prev.loading != next.loading,
                        ),
                      )
                      .state
                      .loading;
                  if (loading) {
                    return Positioned.fill(
                      child: Container(
                        color: Colors.black26,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
