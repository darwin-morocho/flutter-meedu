import 'package:example/app/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

class _MenuItem {
  final String label;
  final String routeName;

  const _MenuItem({
    required this.label,
    required this.routeName,
  });
}

const _pages = [
  _MenuItem(
    label: "Counter example",
    routeName: Routes.COUNTER,
  ),
  _MenuItem(
    label: "Login example clean architecture",
    routeName: Routes.LOGIN,
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (_, __) => Container(
          height: 1,
          color: Colors.black12,
        ),
        itemBuilder: (_, index) {
          final page = _pages[index];
          return ListTile(
            title: Text(page.label),
            onTap: () => router.pushNamed(
              page.routeName,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          );
        },
        itemCount: _pages.length,
      ),
    );
  }
}
