import 'package:flutter/material.dart';

import '../../routes/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.HOME,
            (_) => false,
          ),
          color: Colors.redAccent,
          child: const Text("Log out"),
        ),
      ),
    );
  }
}
