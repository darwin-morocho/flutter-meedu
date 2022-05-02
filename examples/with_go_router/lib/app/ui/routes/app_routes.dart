import 'package:flutter/widgets.dart' show StatelessWidget;
import 'package:flutter_meedu/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:with_go_router/app/ui/pages/color/color_page.dart';
import 'package:with_go_router/app/ui/pages/home/home_page.dart';
import 'package:with_go_router/app/ui/pages/nested/nested_page.dart';
import 'package:with_go_router/app/ui/routes/routes.dart';

import '../pages/counter/counter_page.dart';

mixin AppRoutesMixin on StatelessWidget {
  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: Routes.COUNTER,
        builder: (_, __) => const CounterPage(),
      ),
      GoRoute(
        path: "${Routes.NESTED}/:index",
        builder: (_, state) => NestedPage(
          index: int.tryParse(state.params['index'] ?? '0') ?? 0,
        ),
        routes: [
          GoRoute(
            path: 'primaries/:color',
            builder: (_, state) {
              final colorIndex = int.tryParse(
                    state.params['color'] ?? '0',
                  ) ??
                  0;
              return ColorPage(
                isPrimary: true,
                colorIndex: colorIndex,
              );
            },
          ),
          GoRoute(
            path: 'accents/:color',
            builder: (_, state) {
              final colorIndex = int.tryParse(
                    state.params['color'] ?? '0',
                  ) ??
                  0;
              return ColorPage(
                isPrimary: false,
                colorIndex: colorIndex,
              );
            },
          ),
        ],
      ),
    ],
    observers: [
      router.observer,
    ],
  );
}
