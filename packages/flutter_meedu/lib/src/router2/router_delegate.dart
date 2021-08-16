import 'package:flutter/widgets.dart';

import 'page_container.dart';
import 'route_data.dart';
import 'router_state.dart';
import '../../router.dart' as router;

typedef PageBuilderCallback = Page<dynamic> Function(RouteData);

class MyRouterDelegate extends RouterDelegate<RouteData>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteData> {
  /// The name of the first route to show when the current URL is '/'
  static String _initialRoute = '/';
  static String get initialRoute => _initialRoute;

  /// all routes from this app using navigation 2.0
  final Map<String, PageBuilderCallback> routes;

  /// callback to render a view when a page is not
  /// registered into [routes]
  final PageBuilderCallback onNotFoundPage;

  /// stores all [Page]'s and their [RouteData]
  List<PageContainer> get _history => state.history;

  /// get the RouterState from a singleton
  RouterState get state => RouterState.i;

  /// get the current [RouteData] into state
  RouteData get currentRoute => state.currentRoute;

  /// check if the first route was rendered to avoid a
  /// duplicated initial route
  bool get _initialized => state.initialized;

  /// A list of observers for the navigator created by [MyRouterDelegate]
  ///
  /// by default [MyRouterDelegate] always add the [router.observer] from flutter_meedu
  final List<NavigatorObserver> observers;

  /// use this parameter to catch when a route
  /// has been popped
  bool Function(Route<dynamic>, dynamic)? onPopPage;

  MyRouterDelegate({
    String initialRoute = '/',
    required this.routes,
    required this.onNotFoundPage,
    this.observers = const [],
  }) {
    _initialRoute = initialRoute;
    state.setPaths(
      routes.keys.toList(),
    );
    state.addListener(() {
      setNewRoutePath(currentRoute);
    });
    state.updateNavigator = notifyListeners;
    state.isEnabled = true;
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
        final popped = route.didPop(result);
        if (popped) {
          state.handlePopPage(currentRoute, result);
          notifyListeners(); // this is need it to update the route URL in browsers
        }
        return popped;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteData routeData) async {
    if (_initialized) {
      /// a push event has been called
      /// and we need to update the history
      _insertPageFromData(routeData);

      /// notify to rebuild the Navigator
      notifyListeners();
    } else {
      /// if the first route is rendering
      state.initialize();
    }
  }

  /// return all pages to be rendered in the Navigator
  List<Page> get pages {
    if (_history.isEmpty) {
      _setInitialRoute();
    }
    return _history.map((e) => e.page).toList();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => router.navigatorKey;

  @override
  RouteData? get currentConfiguration => currentRoute;

  /// if the history is empty we use the current route data
  /// as the first element in the history
  void _setInitialRoute() {
    _insertPageFromData(currentRoute);
  }

  /// get the page container for a given route data
  PageContainer _getPageContainer(RouteData routeData) {
    if (routeData.key != null) {
      return PageContainer(
        routes[routeData.key]!(routeData),
        routeData,
      );
    }

    /// if the passed route data doesn't match with
    /// any key into [routes] not found page will be rendered
    return PageContainer(
      onNotFoundPage(routeData),
      routeData,
    );
  }

  /// recive a [routeData] and create its [PageContainer] to
  /// insert it in the history
  void _insertPageFromData(RouteData routeData) {
    final container = _getPageContainer(
      routeData,
    );

    state.updateHistory([
      ..._history,
      container,
    ]);
  }
}
