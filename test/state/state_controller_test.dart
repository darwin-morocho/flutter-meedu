import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';
import 'package:meedu/router.dart' as router;
import 'package:meedu/src/state_managment/controllers/state_controller.dart';

void main() {
  testWidgets('StateController test', (test) async {
    await test.pumpWidget(
      MaterialApp(
        navigatorKey: router.navigatorKey,
        home: HomePage(),
      ),
    );

    await test.tap(find.text("go"));
    // await Future.delayed(Duration(milliseconds: 300));
    await test.pumpAndSettle();
    expect(find.text(""), findsWidgets);
    await test.tap(find.text("set"));
    await test.pump();
    expect(find.text("test"), findsOneWidget);
    expect(find.text("test@test.com"), findsOneWidget);
    await test.tap(find.text("back"));
    await test.pumpAndSettle();
    expect(find.text("test"), findsNothing);
    expect(find.text("go"), findsOneWidget);
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () => router.push(
          LoginPage(),
        ),
        child: Text("go"),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("loginPage");
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            router.pop();
          },
          child: Text("back"),
        ),
      ),
      body: Provider<LoginController>(
        controller: LoginController(),
        child: Builder(
          builder: (context) => Column(
            children: [
              FlatButton(
                onPressed: () {
                  final c = Get.i.find<LoginController>();
                  c.onEmailChanged("test@test.com");
                  c.onPasswordChanged("test");
                },
                child: Text("set"),
              ),
              StateBuilder<LoginController, LoginState>(
                buildWhen: (prev, current) => prev.email != current.email,
                builder: (_) => Text(_.state.email),
              ),
              StateBuilder<LoginController, LoginState>(
                buildWhen: (prev, current) => prev.password != current.password,
                builder: (_) => Text(_.state.password),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginState extends Equatable {
  final String email, password;
  LoginState({
    @required this.email,
    @required this.password,
  });

  LoginState copyWith({
    String email,
    String password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}

class LoginController extends StateController<LoginState> {
  @override
  LoginState get initialState => LoginState(email: '', password: '');

  void onEmailChanged(String email) {
    update(
      this.state.copyWith(email: email),
    );
  }

  void onPasswordChanged(String password) {
    update(
      this.state.copyWith(password: password),
    );
  }

  @override
  Future<void> onDispose() {
    print(":::: dispose login page");
    return super.onDispose();
  }
}
