import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(
    () {
      ProviderScope.clear();
      router.dispose();
    },
  );

  testWidgets(
    'ConsumerWidget null check operator',
    (tester) async {
      _provider.setArguments(
        _User('username'),
      );
      await tester.pumpWidget(
        MaterialApp(
          key: router.appKey,
          navigatorKey: router.navigatorKey,
          initialRoute: '/',
          routes: {
            '/': (_) => _ProfileView(),
            '/login': (_) => _LoginView(),
          },
        ),
      );

      await tester.tap(
        find.byType(TextButton),
      );

      await tester.pumpAndSettle();
      expect(find.byType(_LoginView), findsOneWidget);
    },
  );
}

class _LoginView extends StatelessWidget {
  const _LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class _ProfileView extends ConsumerWidget {
  const _ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(
      _provider.select(
        (_) => _.user != null,
        booleanCallback: true,
      ),
    );

    final username = controller.user!.username;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(username),
            TextButton(
              onPressed: () {
                controller.setUser(null);
                router.pushNamedAndRemoveUntil(
                  '/login',
                );
              },
              child: Text('log out'),
            ),
          ],
        ),
      ),
    );
  }
}

final _provider = SimpleProvider(
  (ref) => _SessionController(ref.arguments),
);

class _SessionController extends SimpleNotifier {
  _SessionController(this._user);

  _User? _user;
  _User? get user => _user;

  void setUser(_User? user) {
    _user = user;
    notify();
  }
}

class _User {
  final String username;

  _User(this.username);
}
