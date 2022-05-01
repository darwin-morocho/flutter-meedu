import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/ui.dart';

void main() {
  testWidgets(
    'AfterFirstLayoutMixin',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const _Page(),
        ),
      );
      await tester.pump();
      expect(find.byType(AlertDialog), findsOneWidget);
    },
  );
}

class _Page extends StatefulWidget {
  const _Page({Key? key}) : super(key: key);

  @override
  State<_Page> createState() => __PageState();
}

class __PageState extends State<_Page> with AfterFirstLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text('after first layout'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
