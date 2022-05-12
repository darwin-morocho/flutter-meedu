import 'package:example/app/my_app.dart';
import 'package:example/app/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../set_up.dart';

void main() {
  setUpTests();

  testWidgets(
    'CounterPage',
    (tester) async {
      await tester.pumpWidget(
        const MyApp(
          initialRoute: Routes.COUNTER,
        ),
      );

      expect(find.text("0"), findsOneWidget);
      await tester.tap(
        find.byType(FloatingActionButton),
      );
      await tester.pump();
      expect(find.text("1"), findsOneWidget);
    },
  );
}
