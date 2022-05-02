import 'package:example/app/my_app.dart';
import 'package:example/app/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../set_up.dart';

void main() {
  setUpTests();

  testWidgets(
    'SplashPage',
    (tester) async {
      await tester.pumpWidget(
        const MyApp(
          key: Key('test_app'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    },
  );
}
