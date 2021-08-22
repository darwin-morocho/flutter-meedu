import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/src/router2/route_data.dart';
import 'package:flutter_meedu/router.dart' as router;

class NestedRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  final GlobalKey<NavigatorState> navigatorKey;

  late List<Page> _pages;

  NestedRouterDelegate({
    required this.navigatorKey,
    required List<Page> initialRoutes,
  }) {
    assert(initialRoutes.isNotEmpty);
    _pages = initialRoutes;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      observers: [
        router.observer,
      ],
      pages: [..._pages],
      onPopPage: (route, result) {
        if (_pages.length > 1 && route.didPop(result)) {
          _pages.removeLast();
          notifyListeners();
          return true;
        }
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}

  @override
  String? get currentConfiguration => _pages.last.name;
}

class NestedRouteParser extends RouteInformationParser<String> {
  @override
  SynchronousFuture<String> parseRouteInformation(RouteInformation routeInformation) {
    return SynchronousFuture(
      routeInformation.location ?? "",
    );
  }

  @override
  RouteInformation? restoreRouteInformation(String configuration) {
    // TODO: implement restoreRouteInformation
    return RouteInformation(location: configuration);
  }
}

class NestedRouteInformationProvider extends RouteInformationProvider {
  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  // TODO: implement value
  RouteInformation? get value => RouteInformation(location: '/homes');
}

class NestedRouterWidget extends StatelessWidget {
  final NestedRouterDelegate routerDelegate;
  const NestedRouterWidget({
    Key? key,
    required this.routerDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final childBackButtonDispatcher = ChildBackButtonDispatcher(
      Router.of(context).backButtonDispatcher!,
    );
    childBackButtonDispatcher.takePriority();

    return Router(
      routerDelegate: routerDelegate,
      backButtonDispatcher: childBackButtonDispatcher,
      routeInformationParser: NestedRouteParser(),
      routeInformationProvider: NestedRouteInformationProvider(),
    );
  }
}
