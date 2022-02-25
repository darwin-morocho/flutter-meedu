import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';

class _MenuItem {
  final String label;
  final String routeName;
  final bool isPush;

  const _MenuItem({
    required this.label,
    required this.routeName,
    this.isPush = true,
  });
}

const _pages = [
  _MenuItem(
    label: "Counter example",
    routeName: Routes.COUNTER,
  ),
  _MenuItem(
    label: "Nested example",
    routeName: "${Routes.NESTED}/1",
    isPush: false,
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("meedu and Go Router"),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Container(
          height: 1,
          color: Colors.black12,
        ),
        itemBuilder: (_, index) {
          final page = _pages[index];
          return ListTile(
            title: Text(page.label),
            onTap: () {
              if (page.isPush) {
                context.push(page.routeName);
              } else {
                context.go(page.routeName);
              }
            },
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
