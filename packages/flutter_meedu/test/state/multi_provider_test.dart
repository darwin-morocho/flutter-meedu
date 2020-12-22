import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

void main() {
  group('Multiprovider', () {
    test("assert(child != null && providers != null)", () {
      expect(() {
        MultiProvider(child: null, providers: null);
      }, throwsAssertionError);
    });

    test("assert(child != null)", () {
      expect(() {
        MultiProvider(child: null, providers: []);
      }, throwsAssertionError);
    });

    testWidgets('MultiProvider Test', (test) async {
      await test.pumpWidget(
        MultiProvider(
          providers: [
            Provider<UserController>(
              create: (_) => UserController(
                User(id: -1, email: '', username: ''),
              ),
            ),
            Provider<CounterController>(create: (_) => CounterController()),
          ],
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );
      expect(find.text("counter 0"), findsOneWidget);
      expect(find.text("-1"), findsOneWidget);
      expect(find.text(""), findsWidgets);

      await test.tap(find.text("add"));
      await test.pump();
      expect(find.text("counter 1"), findsOneWidget);

      await test.tap(find.text("update user"));
      await test.pump();
      expect(find.text("12345"), findsOneWidget);
      expect(find.text("meedu"), findsOneWidget);
    });
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StateBuilder<UserController, User>(
            builder: (_) => Column(
              children: [
                Text("${_.state.id}"),
                Text("${_.state.username}"),
                Text("${_.state.email}"),
              ],
            ),
          ),
          SimpleBuilder<CounterController>(
            builder: (_) => Text("counter ${_.counter}"),
          )
        ],
      ),
      floatingActionButton: Row(
        children: [
          FlatButton(
            onPressed: () {
              final CounterController c = Get.i.find<CounterController>();
              c.add();
            },
            child: Text("add"),
          ),
          FlatButton(
            onPressed: () {
              final UserController c = Get.i.find<UserController>();
              c.update(
                User(id: 12345, username: "meedu", email: "test@test.com"),
              );
            },
            child: Text("update user"),
          ),
        ],
      ),
    );
  }
}

class CounterController extends SimpleController {
  int counter = 0;
  void add() {
    counter++;
    update();
  }
}

class UserController extends StateController<User> {
  UserController(User initialState) : super(initialState);
}

class User {
  final int id;
  final String username, email;

  User({
    this.id,
    this.username,
    this.email,
  });

  User copyWith({
    int id,
    String username,
    String email,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? email,
    );
  }

  Map toJson() => {"id": id, "email": email, "username": username};
}
