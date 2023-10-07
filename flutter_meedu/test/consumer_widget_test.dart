// ignore_for_file: avoid_unnecessary_containers

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/provider/provider_scope.dart';
import 'package:flutter_test/flutter_test.dart';

final _provider = StateNotifierProvider<LoginController, LoginState>(
  (_) => LoginController(),
);

void main() {
  setUp(ProviderScope.clear);
  testWidgets('StateController test', (test) async {
    await test.pumpWidget(
      const MaterialApp(
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
    expect(_provider.mounted, false);
    expect(find.text("go"), findsOneWidget);
  });

  testWidgets(
    'Consumer > StateProvider > .when only with ref.watch',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Consumer(
              builder: (_, ref, child) {
                ref.select(
                  _provider.when((prev, current) => false),
                );
                return const Text("");
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
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
        ),
        child: const Text("go"),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("back"),
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
            child: const Text("set"),
          ),
          TextButton(
            onPressed: () {
              final c = _provider.read;
              c.onEmailChanged("test.com");
            },
            child: const Text("set invalid value"),
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
          const LoginDetail(),
        ],
      ),
    );
  }
}

class LoginDetail extends ConsumerWidget {
  const LoginDetail({super.key});

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
        const SizedBox(height: 20),
        const Text(":::StateWidget:::"),
        Text("Email: $email"),
        Text("Password: $password"),
        TextButton(
          onPressed: reset,
          child: const Text("reset"),
        ),
      ],
    );
  }
}

class LoginState extends Equatable {
  final String email, password;

  const LoginState({
    required this.email,
    required this.password,
  });

  static LoginState get initialState =>
      const LoginState(email: '', password: '');

  LoginState copyWith({
    String? email,
    String? password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map toJson() => {"email": email, "password": password};

  @override
  List<Object> get props => [email, password];
}

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
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
