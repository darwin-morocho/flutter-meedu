import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'back_button_response.dart';
import 'page_container.dart';
import 'route_data.dart';
import 'router_state.dart';
import '../../router.dart' as router;

typedef PageBuilderCallback = Page<dynamic> Function(RouteData);
typedef OnBackButtonCallback = Future<BackButtonResponse> Function(
    Route route, RouteData routeData);

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
  RouteData get currentData => state.currentData;

  Route get currentRoute => state.currentRoute;

  /// use this parameter to catch the back
  /// button on Android
  /// 
  /// WARNING: if you use this parameter the [WillPopScope] widget
  /// cannot catch the back button on Android
  final OnBackButtonCallback? onBackButton;

  /// A list of observers for the navigator created by [MyRouterDelegate]
  ///
  /// by default [MyRouterDelegate] always add the [router.observer] from flutter_meedu
  final List<NavigatorObserver> observers;

  MyRouterDelegate({
    String initialRoute = '/',
    required this.routes,
    required this.onNotFoundPage,
    this.onBackButton,
    this.observers = const [],
  }) {
    // MyBackButtonDispatcher(this);
    _history.clear();
    _initialRoute = initialRoute;
    state.setPaths(
      routes.keys.toList(),
    );
    state.addListener(notifyListeners);
    state.onAddPage = _onAddPage;
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
        if (route.didPop(result)) {
          return _onPopPage(route, result);
        }
        return false;
      },
    );
  }

  @override
  Future<void> setInitialRoutePath(RouteData configuration) {
    // state.initialize();
    return SynchronousFuture(null);
  }

  @override
  Future<void> setNewRoutePath(RouteData routeData) async {
    /// check if the incomming route data
    /// is inside the current history, if it is true
    /// that means that the user has pressed
    /// the back button
    final urls = _history.map((e) => e.id).toList();
    final isBackButtonPressed = urls.contains(routeData.fullPath);
    if (isBackButtonPressed) {
      if (_history.length == 1) {
        _history.clear();
        _insertPageFromData(routeData);
      } else {
        final removed = _history.removeLast();
        notifyListeners();
        removed.data.popCompleter.complete(null);
      }
    } else {
      /// the user has pressed the next button
      _insertPageFromData(routeData);
    }

    return SynchronousFuture(null);
  }

  void _onAddPage(RouteData routeData) {
    /// a push event has been called
    /// and we need to update the history
    _insertPageFromData(routeData);

    /// notify to rebuild the Navigator
    notifyListeners();
  }

  /// return all pages to be rendered in the Navigator
  List<Page> get pages {
    if (_history.isEmpty) {
      _setInitialRoute();
    }
    return [
      ..._history.map((e) => e.page),
    ];
  }

  /// check if the history has at least
  /// 2 pages to allow pop events, if the
  /// history only has one route and the SO is Android
  /// the app should close
  bool canPop() {
    return _history.length > 1;
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => router.navigatorKey;

  @override
  RouteData? get currentConfiguration => currentData;

  /// if the history is empty we use the current route data
  /// as the first element in the history
  void _setInitialRoute() {
    _insertPageFromData(state.initialRouteData!);
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
    _history.add(container);
  }

  /// handle the pop events when
  /// pop methods are called or [onBackButton] is defined
  bool _onPopPage(Route route, dynamic result) {
    if (canPop()) {
      state.handlePopPage(currentData, result);
      return true;
    }
    return false;
  }

  @override
  Future<bool> popRoute() async {
    /// if back button is handled by the current delegate
    if (onBackButton != null) {
      final response = await onBackButton!(
        currentRoute,
        currentData,
      );

      /// check if the pop event is allowed
      /// and pop is posible
      if (response.allowPop) {
        return _onPopPage(
          currentRoute,
          response.result,
        );
      }

      /// return true to prevent app close
      return true;
    }
    return super.popRoute();
  }
}
