import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';

void main() {
  testWidgets(
    "test auto remove",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: router.navigatorKey,
          navigatorObservers: [
            router.observer,
          ],
          initialRoute: '/lulu',
          routes: {
            '/lulu': (_) => _Page(
                  pageName: '/lulu',
                  onPressed: () {
                    router.pushReplacementNamed('/oso');
                  },
                ),
            '/oso': (_) => Scaffold(
                  body: Center(
                    child: TextButton(
                      key: Key('/oso'),
                      child: Text("go"),
                      onPressed: () {
                        router.pushReplacementNamed('/lulu');
                      },
                    ),
                  ),
                ),
          },
        ),
      );

      var pet = Get.find<Pet>();
      int hash1 = pet.hashCode;
      expect(pet.name, '/lulu');
      await tester.tap(find.byKey(Key('/lulu')));
      await tester.pumpAndSettle();
      expect(Get.has<Pet>(), false);
      await tester.tap(find.byKey(Key('/oso')));
      await tester.pumpAndSettle();
      pet = Get.find<Pet>();
      expect(pet.name, '/lulu');
      expect(pet.hashCode != hash1, true);
    },
  );
}

class _Page extends StatefulWidget {
  final String pageName;
  final VoidCallback onPressed;
  _Page({Key? key, required this.pageName, required this.onPressed}) : super(key: key);

  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  @override
  void initState() {
    super.initState();
    Get.put<Pet>(Pet(widget.pageName), autoRemove: true, onRemove: (pet) {
      print("🤠 removed ${pet.name}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          key: Key('${widget.pageName}'),
          child: Text("go"),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}

class Pet {
  final String name;

  Pet(this.name);
}
