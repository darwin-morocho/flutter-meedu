import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';

final _provider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);

void main() {
  tearDown(() {
    _provider.dispose();
  });
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
    expect(find.text("watch: test@test.com"), findsOneWidget);

    // test onStateWillChange
    await test.tap(find.text("set invalid value"));
    await test.pump();
    expect(find.text("test@test.com"), findsOneWidget);
    expect(find.text("Email: test@test.com"), findsOneWidget);
    // end onStateWillChange

    await test.tap(find.text("reset"));
    await test.pump();
    expect(find.text("test"), findsNothing);
    expect(find.text("test@test.com"), findsNothing);

    await test.tap(find.text("back"));
    await test.pumpAndSettle();
    expect(find.text("test"), findsNothing);
    expect(find.text("go"), findsOneWidget);
  });

  testWidgets(
    'Consumer > StateProvider > .when only with ref.watch',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: router.navigatorKey,
          home: Scaffold(
            body: Consumer(
              builder: (_, ref, child) {
                ref.select(
                  _provider.when((prev, current) => false),
                );
                return Text("");
              },
            ),
          ),
        ),
      );

      expect(
        tester.takeException(),
        isInstanceOf<AssertionError>(),
      );
    },
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () => router.push(
          LoginPage(),
        ),
        child: Text("go"),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("loginPage");
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            router.pop();
          },
          child: Text("back"),
        ),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              final c = _provider.read;
              c.onEmailChanged("test@test.com");
              c.onPasswordChanged("test");
            },
            child: Text("set"),
          ),
          TextButton(
            onPressed: () {
              final c = _provider.read;
              c.onEmailChanged("test.com");
            },
            child: Text("set invalid value"),
          ),
          Consumer(builder: (_, ref, __) {
            final email = ref.select(
              _provider.select((_) => _.email),
            );
            return Text(email);
          }),
          Consumer(builder: (_, ref, __) {
            final email = ref
                .watch(
                  _provider.select((_) => _.email),
                )
                .state
                .email;
            return Text("watch: $email");
          }),
          Consumer(builder: (_, ref, __) {
            final state = ref
                .watch(
                  _provider.when(
                      (prev, current) => prev.password != current.password),
                )
                .state;
            return Text(state.password);
          }),
          LoginDetail(),
        ],
      ),
    );
  }
}

class LoginDetail extends ConsumerWidget {
  void reset() {
    final controller = _provider.read;
    // ignore: invalid_use_of_protected_member
    controller.state = controller.state.copyWith(email: '@', password: '');
  }

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(_provider);
    final email = controller.state.email;
    final password = controller.state.password;
    return Column(
      children: [
        SizedBox(height: 20),
        Text(":::StateWidget:::"),
        Text("Email: $email"),
        Text("Password: $password"),
        TextButton(
          onPressed: this.reset,
          child: Text("reset"),
        ),
      ],
    );
  }
}

class LoginState extends Equatable {
  final String email, password;

  LoginState({
    required this.email,
    required this.password,
  });

  static LoginState get initialState => LoginState(email: '', password: '');

  LoginState copyWith({
    String? email,
    String? password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map toJson() => {"email": this.email, "password": this.password};

  @override
  List<Object> get props => [email, password];
}

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = this.state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = this.state.copyWith(password: password);
  }

  @override
  bool onStateWillChange(LoginState oldState, LoginState newState) {
    if (oldState.email != newState.email) {
      return newState.email.contains("@");
    }
    return true;
  }

  @override
  void onStateChanged(LoginState oldState, LoginState currentState) {
    print("oldState ${oldState.toJson()}");
    print("currentState ${currentState.toJson()}\n\n");
  }

  @override
  void dispose() {
    print(":::: dispose login page");
    super.dispose();
  }
}
