import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

void main() {
  group('Multiprovider', () {
    testWidgets('MultiProvider Test', (test) async {
      await test.pumpWidget(
        MultiProvider(
          providers: [
            MultiProviderItem<UserController>(
              create: (_) => UserController(
                User(id: -1, email: '', username: ''),
              ),
            ),
            MultiProviderItem<CounterController>(create: (_) => CounterController()),
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
      print("🐶");
    });
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StateBuilder<UserController, User>(
            builder: (context, _) => Column(
              children: [
                Text("${_.state.id}"),
                Text("${_.state.username}"),
                Text("${_.state.email}"),
              ],
            ),
          ),
          SimpleBuilder<CounterController>(
            builder: (context, _) => Text("counter ${_.counter}"),
          )
        ],
      ),
      floatingActionButton: Row(
        children: [
          TextButton(
            onPressed: () {
              final CounterController c = Get.i.find<CounterController>();
              c.add();
            },
            child: Text("add"),
          ),
          TextButton(
            onPressed: () {
              final UserController c = Get.i.find<UserController>();
              c.state = User(id: 12345, username: "meedu", email: "test@test.com");
            },
            child: Text("update user"),
          ),
        ],
      ),
    );
  }
}

class CounterController extends SimpleNotifier {
  int counter = 0;
  void add() {
    counter++;
    notify();
  }
}

class UserController extends StateNotifier<User> {
  UserController(User initialState) : super(initialState);
}

class User {
  final int id;
  final String username, email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  User copyWith({
    int? id,
    String? username,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map toJson() => {"id": id, "email": email, "username": username};
}
