import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier, Route;
import 'web/export.dart';
import '../../router.dart' as router;

import 'page_container.dart';
import 'path_parser.dart';
import 'route_data.dart';
import 'route_parser.dart';

class RouterState extends ChangeNotifier {
  RouterState._();
  static final RouterState i = RouterState._();

  final _web = WebUtils();

  /// routes all paths (key) from [routes] property of [MyRouterDelegate]
  List<String> _routerKeys = [];
  List<String> get routerKeys => _routerKeys;

  /// stores all [Page]'s and their [RouteData]
  List<PageContainer> _pages = [];
  List<PageContainer> get pages => _pages;

  List<String> _history = [];
  List<String> get history => _history;

  /// the initial route data for the first page in the navigator
  RouteData? _initialRouteData;
  RouteData? get initialRouteData => _initialRouteData;

  /// callback to notify to a MyRouterDelegate that it needs
  /// to add a new page into the navigator
  late void Function(RouteData routeData) onAddPage;

  /// store the current route in the navigator
  late Route _currentRoute;
  Route get currentRoute => _currentRoute;

  /// returns the current route data
  RouteData? get currentData => _pages.isNotEmpty ? _pages.last.data : null;

  /// is true when navigator 2.0 is using
  bool _isEnabled = false;

  bool isReplacement = false;

  /// is true when navigator 2.0 is using
  bool get isEnabled => _isEnabled;

  /// update the _isEnabled property to know
  /// if the app is using navigator 2.0
  void set isEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// save all routes keys in one instance of MyRouterDElegate
  void setPaths(List<String> keys) {
    _routerKeys = keys;
  }

  /// the the initial route data for the first page that will
  /// be rendered into navigator
  void setInitialRouteData(RouteData routeData) {
    _initialRouteData = routeData;
  }

  /// save the current route in the navigator
  void setCurrentRoute(Route route) {
    _currentRoute = route;
  }

  /// search the popped route and delete it from history
  void handlePopPage(
    RouteData routeData,
    dynamic result, {
    bool notify = true,
  }) {
    // get the position of the popped route into history
    final index = _pages.indexWhere(
      (e) => e.data.id == routeData.id,
    );
    if (index != -1) {
      final removedContainer = _pages.removeAt(index);
      _history.add(removedContainer.data.id);
      // use  the pop completer to return a result value
      // after pop event
      if (notify) {
        notifyListeners(); // this is need it to update the route URL in browsers
      }
      removedContainer.data.popCompleter.complete(result);
    }
  }

  /// push a new route into history
  ///
  /// [path] should be a string like '/product/123'
  ///
  /// [queryParameters] query parameters for the  current path
  /// for example if we have the next path '/search' and
  /// the  next query parameters { 'q':'flutter' } the full path
  /// will be '/search?q=flutter'
  ///
  /// [parameters] optional value to send a custom model or
  /// one instance of some class
  FutureOr<T?> push<T>(
    String path, {
    Map<String, String> queryParameters = const {},
    dynamic parameters,
    bool isReplacement = false,
  }) {
    /// create a tmp uri to get some query parameters
    /// from [path]
    final tmpUri = Uri.parse(path);

    // uri to be used for the route data
    final uri = Uri(
      path: getPathWithoutQuery(path),
      queryParameters: {
        ...tmpUri.queryParameters,
        ...queryParameters,
      },
    );

    /// check to avoid duplicated pages
    if (uri.toString() != currentData?.fullPath) {
      final keyAndParameters = getRouteKeyAndParameters(uri);
      final routeData = RouteData<T>(
        requestSource: RequestSource.system,
        routeKey: keyAndParameters?.routeKey,
        uri: uri,
        state: RouteState(isReplacement: isReplacement),
        parameters: parameters,
        pathParameters: keyAndParameters?.parameters ?? {},
      );
      if (isReplacement && kIsWeb) {
        this.isReplacement = true;
        _web.replaceState(null, 'el exito', routeData.fullPath);
      }
      onAddPage(routeData);

      return routeData.popCompleter.future;
    }
  }

  /// Replace the current page of the history by pushing the given page and
  /// then disposing the previous page
  FutureOr<T?> pushReplacement<T extends Object?, TO extends Object?>(
    String path, {
    Map<String, String> queryParameters = const {},
    dynamic parameters,
    TO? result,
  }) {
    final popedRouteData = _pages.removeLast().data;
    popedRouteData.popCompleter.complete(
      result,
    );
    _history.add(popedRouteData.fullPath);

    return push<T>(
      path,
      queryParameters: queryParameters,
      parameters: parameters,
      isReplacement: true,
    );
  }

  /// remove the current page from history
  void pop<T>([T? result]) {
    router.pop<T>();
  }

  /// remove all pages in the history until [predicate]
  void popUntil([bool Function(Route)? predicate]) {
    router.popUntil(predicate);
  }
}
