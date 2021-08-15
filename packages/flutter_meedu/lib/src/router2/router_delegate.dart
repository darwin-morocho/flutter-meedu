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

  final PageBuilderCallback onNotFoundPage;

  /// stores all [Page]'s and their [RouteData]
  List<PageContainer> _history = [];

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

  /// search the popped route and delete it from history
  void _handlePopPage(Route route, dynamic result) {
    final copy = [..._history]; // create a copy from current history
    // get the position of the popped route into history
    final index = copy.indexWhere(
      (e) => e.data.fullPath == currentRoute.fullPath,
    );
    if (index != -1) {
      final removedContainer = copy.removeAt(index);
      // use  the pop completer to return a result value
      // after pop event
      removedContainer.data.popCompleter.complete(result);

      // update history and current route data with the last page in history
      _history = copy;
      state.setState(_history.last.data);
      notifyListeners(); // this is need it to update the route URL in browsers
    }
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
    _history = [
      ..._history,
      _getPageContainer(
        routeData,
      ),
    ];
  }
}
