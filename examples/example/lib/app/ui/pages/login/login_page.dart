import 'package:example/app/ui/pages/login/controller/login_controller.dart';
import 'package:example/app/ui/pages/login/utils/send_login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'controller/login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  LoginController get controller => loginProvider.read;

  bool isValidEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.replaceAll(" ", "").isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SelectableText("E-mail: eve.holt@reqres.in"),
                const SelectableText("Password: cityslicka"),
                const SizedBox(height: 45),
                Consumer(
                  builder: (_, ref, child) {
                    final email = ref.select(
                      loginProvider.select((_) => _.email),
                    );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        child!,
                        if (!isValidEmail(email))
                          const Text(
                            "Invalid email",
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                      ],
                    );
                  },
                  child: TextField(
                    key: const Key('login-email'),
                    onChanged: (text) => controller.onEmailChanged(text),
                    decoration: const InputDecoration(
                      label: Text("E-mail"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  key: const Key('login-password'),
                  onChanged: (text) => controller.onPasswordChanged(text),
                  decoration: const InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 25),
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(loginProvider).state;

                    final isValidForm = isValidEmail(state.email) &&
                        isValidPassword(state.password);

                    return MaterialButton(
                      key: const Key('login-submit-button'),
                      minWidth: double.infinity,
                      onPressed:
                          isValidForm ? () => sendLoginForm(context) : null,
                      child: const Text("Sign In"),
                      disabledColor: Colors.blueAccent.withOpacity(0.5),
                      color: Colors.blueAccent,
                    );
                  },
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
