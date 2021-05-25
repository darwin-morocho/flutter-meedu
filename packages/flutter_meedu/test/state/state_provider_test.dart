import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';

import 'state_controller_test.dart';

void main() {
  testWidgets('state provider test', (tester) async {
    int emailCounter = 0, passwordCounter = 0, bothCounter = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              CupertinoTextField(
                key: Key('email-input'),
                onChanged: loginProvider.read.onEmailChanged,
              ),
              CupertinoTextField(
                key: Key('password-input'),
                onChanged: loginProvider.read.onPasswordChanged,
              ),
              Consumer(
                builder: (_, watch, __) {
                  final controller = watch<LoginController, LoginState>(
                    loginProvider,
                    WatchFilter(
                      when: (prev, current) => prev.email != current.email,
                    ),
                  );
                  emailCounter++;
                  return Text("${controller.state.email}");
                },
              ),
              Consumer(
                builder: (_, watch, __) {
                  final controller = watch<LoginController, LoginState>(
                    loginProvider,
                    WatchFilter(
                      when: (prev, current) => prev.password != current.password,
                    ),
                  );
                  passwordCounter++;
                  return Text("${controller.state.password}");
                },
              ),
              Consumer(
                builder: (_, watch, __) {
                  watch<LoginController, LoginState>(loginProvider);
                  bothCounter++;
                  return Text("");
                },
              ),
            ],
          ),
        ),
      ),
    );

    expect(emailCounter, 1);
    expect(passwordCounter, 1);
    await tester.enterText(find.byKey(Key('email-input')), 'test@test.com');
    await tester.pump();

    expect(emailCounter, 2);
    expect(passwordCounter, 1);
    await tester.enterText(find.byKey(Key('password-input')), '12345');
    await tester.pump();
    expect(emailCounter, 2);
    expect(passwordCounter, 2);
    expect(bothCounter, 3);

    expect(find.text("12345"), findsWidgets);
    expect(find.text("test@test.com"), findsWidgets);
  });
}

final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);
