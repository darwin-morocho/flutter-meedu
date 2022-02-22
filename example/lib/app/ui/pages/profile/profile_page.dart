import 'package:example/app/ui/routes/routes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/router.dart' as router;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () => router.pushNamedAndRemoveUntil(Routes.HOME),
          color: Colors.redAccent,
          child: const Text("Log out"),
        ),
      ),
    );
  }
}
