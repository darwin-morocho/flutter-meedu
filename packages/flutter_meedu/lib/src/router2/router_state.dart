import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier, PageRoute, Route;
import '../../router.dart' as router;

import 'page_container.dart';
import 'path_parser.dart';
import 'route_data.dart';
import 'route_parser.dart';

class RouterState extends ChangeNotifier {
  RouterState._();
  static final RouterState i = RouterState._();

  /// routes all paths (key) from [routes] property of [MyRouterDelegate]
  List<String> _routerKeys = [];
  List<String> get routerKeys => _routerKeys;

  /// stores all [Page]'s and their [RouteData]
  List<PageContainer> _history = [];
  List<PageContainer> get history => _history;

  late RouteData _currentRoute;

  late void Function() updateNavigator;

  /// returns the current route data
  RouteData get currentRoute => _currentRoute;

  /// is true when navigator 2.0 is using
  bool _isEnabled = false;

  /// is true when navigator 2.0 is using
  bool get isEnabled => _isEnabled;

  /// its  value will be true after first page is into history
  bool _initialized = false;
  bool get initialized => _initialized;

  Completer? _transitionCompleter;

  void set isEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// save all routes keys in one instance of MyRouterDElegate
  void setPaths(List<String> keys) {
    _routerKeys = keys;
  }

  ///
  void setState(RouteData routeData) {
    _currentRoute = routeData;
  }

  ///
  void initialize() {
    _initialized = true;
  }

  void updateHistory(List<PageContainer> history) {
    _history = history;
  }

  void onTransitionFinisehd(PageRoute route) {
    _transitionCompleter?.complete();
    _transitionCompleter = null;
  }

  /// search the popped route and delete it from history
  void handlePopPage(RouteData routeData, dynamic result) {
    final copy = [..._history]; // create a copy from current history
    // get the position of the popped route into history
    final index = copy.indexWhere(
      (e) => e.data.fullPath == routeData.fullPath,
    );
    if (index != -1) {
      final removedContainer = copy.removeAt(index);
      // use  the pop completer to return a result value
      // after pop event
      removedContainer.data.popCompleter.complete(result);

      // update history and current route data with the last page in history
      _history = copy;
      _currentRoute = _history.last.data;
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
    if (uri.toString() != currentRoute.fullPath) {
      final keyAndParameters = getRouteKeyAndParameters(uri);
      final routeData = RouteData<T>(
        key: keyAndParameters?.routeKey,
        uri: uri,
        state: null,
        parameters: parameters,
        pathParameters: keyAndParameters?.parameters ?? {},
      );
      _currentRoute = routeData;
      notifyListeners();
      return routeData.popCompleter.future;
    }
  }

  /// Replace the current page of the history by pushing the given page and
  /// then disposing the previous page once the new page has finished
  /// animating in.
  ///
  ///
  FutureOr<T?> pushReplacement<T extends Object?, TO extends Object?>(
    String path, {
    Map<String, String> queryParameters = const {},
    dynamic parameters,
    TO? result,
  }) {
    final prevRoute = currentRoute;
    _transitionCompleter = Completer();
    _transitionCompleter?.future.then(
      (_) {
        handlePopPage(prevRoute, result);
        updateNavigator(); // this is need it to update the route URL in browsers
      },
    );
    return push<T>(
      path,
      queryParameters: queryParameters,
      parameters: parameters,
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
