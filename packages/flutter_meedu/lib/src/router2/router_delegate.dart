import 'package:flutter/widgets.dart';

import 'page_container.dart';
import 'route_data.dart';
import 'router_state.dart';
import '../../router.dart' as router;

typedef PageBuilderCallback = Page<dynamic> Function(RouteData);

class MyRouterDelegate extends RouterDelegate<RouteData>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteData> {
  /// all routes from this app using navigation 2.0
  final Map<String, PageBuilderCallback> routes;

  final PageBuilderCallback onNotFoundPage;

  /// stores all [Page]'s and their [RouteData]
  List<PageContainer> _containers = [];

  /// get the RouterState from a singleton
  RouterState get state => RouterState.i;

  /// get the current [RouteData] into state
  RouteData get currentRoute => state.currentRoute;

  /// check if the first route was rendered to avoid a
  /// duplicated initial route
  bool _initialized = false;

  /// A list of observers for the navigator created by [MyRouterDelegate]
  ///
  /// by default [MyRouterDelegate] always add the [router.observer] from flutter_meedu
  final List<NavigatorObserver> observers;

  /// use this parameter to catch when a route
  /// has been popped
  bool Function(Route<dynamic>, dynamic)? onPopPage;

  MyRouterDelegate({
    required this.routes,
    required this.onNotFoundPage,
    this.observers = const [],
  }) {
    state.setPaths(
      routes.keys.toList(),
    );
    state.addListener(() {
      setNewRoutePath(currentRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: pages,
      observers: [
        router.observer,
        ...observers,
      ],
      onPopPage: (route, result) {
        late bool popped;
        if (onPopPage != null) {
          popped = onPopPage!(route, result);
        } else {
          popped = route.didPop(result);
        }

        if (popped) {
          _handlePopPage(route, result);
        }
        return popped;
      },
    );
  }

  void _handlePopPage(Route route, dynamic result) {
    final copy = [..._containers];
    final index = copy.indexWhere(
      (e) => e.data.uri.path == currentRoute.uri.path,
    );
    // print("index $index");
    if (index != -1) {
      copy.removeAt(index);
      _containers = copy;
      state.setState(_containers.last.data);
      notifyListeners();
      // print("removed");
    }
  }

  @override
  Future<void> setNewRoutePath(RouteData routeData) async {
    if (_initialized) {
      _insertPageFromData(routeData);
      notifyListeners();
    }
    _initialized = true;
  }

  List<Page> get pages {
    if (_containers.isEmpty) {
      _setInitialRoute();
    }
    // print("🥶 ${_containers.length}");
    return _containers.map((e) => e.page).toList();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => router.navigatorKey;

  @override
  RouteData? get currentConfiguration => currentRoute;

  void _setInitialRoute() {
    _containers = [
      ..._containers,
      _getPageContainer(
        currentRoute,
      ),
    ];
  }

  /// get the page countainer for a given route data
  PageContainer _getPageContainer(RouteData routeData) {
    if (routeData.key != null) {
      return PageContainer(
        routes[routeData.key]!(routeData),
        routeData,
      );
    }

    return PageContainer(
      onNotFoundPage(routeData),
      routeData,
    );
  }

  void _insertPageFromData(RouteData routeData) {
    _containers = [
      ..._containers,
      _getPageContainer(
        routeData,
      ),
    ];
  }
}
