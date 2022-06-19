import 'package:example/app/my_app.dart';
import 'package:example/app/ui/pages/profile/profile_page.dart';
import 'package:example/app/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/http_client.dart';
import '../../../../set_up.dart';

void main() {
  setUpTests();

  final emailFinder = find.byKey(
    const Key('login-email'),
  );

  final passwordFinder = find.byKey(
    const Key('login-password'),
  );

  final buttonFinder = find.byKey(
    const Key('login-submit-button'),
  );

  testWidgets(
    'LoginPage > ok',
    (tester) async {
      MockHttp.loginOk();

      await tester.pumpWidget(
        const MyApp(
          initialRoute: Routes.LOGIN,
        ),
      );

      MaterialButton submitButton = tester.widget(buttonFinder);
      expect(submitButton.onPressed, isNull);

      await tester.enterText(emailFinder, 'text');
      await tester.pump();
      expect(find.text('Invalid email'), findsOneWidget);

      await tester.enterText(passwordFinder, 'test');
      await tester.enterText(emailFinder, 'test@test.com');
      await tester.pump();
      expect(find.text('Invalid email'), findsNothing);
      submitButton = tester.widget(buttonFinder);
      expect(submitButton.onPressed, isNotNull);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(ProfilePage), findsOneWidget);
    },
  );

  testWidgets(
    'LoginPage > network error',
    (tester) async {
      MockHttp.networkError();

      await tester.pumpWidget(
        const MyApp(
          initialRoute: Routes.LOGIN,
        ),
      );

      await tester.enterText(passwordFinder, 'test');
      await tester.enterText(emailFinder, 'test@test.com');
      await tester.pump();

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(find.text('Network error'), findsOneWidget);
    },
  );

  testWidgets(
    'LoginPage > invalid credentials',
    (tester) async {
      MockHttp.loginInvalidCredentials();

      await tester.pumpWidget(
        const MyApp(
          initialRoute: Routes.LOGIN,
        ),
      );

      await tester.enterText(passwordFinder, 'test');
      await tester.enterText(emailFinder, 'test@test.com');
      await tester.pump();

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(find.text('Invalid credentials'), findsOneWidget);
    },
  );

  testWidgets(
    'LoginPage > internal error',
    (tester) async {
      MockHttp.unhandledError();

      await tester.pumpWidget(
        const MyApp(
          initialRoute: Routes.LOGIN,
        ),
      );

      await tester.enterText(passwordFinder, 'test');
      await tester.enterText(emailFinder, 'test@test.com');
      await tester.pump();

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(find.text('Unknown error'), findsOneWidget);
    },
  );
}
