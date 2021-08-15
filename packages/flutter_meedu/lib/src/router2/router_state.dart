import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;


import 'path_parser.dart';
import 'route_data.dart';
import 'route_parser.dart';

class RouterState extends ChangeNotifier {
  RouterState._();
  static final RouterState i = RouterState._();

  /// routes all paths (key) from [routes] property of [MyRouterDelegate]
  List<String> _routerKeys = [];
  List<String> get routerKeys => _routerKeys;

  late RouteData _currentRoute;

  /// returns the current route data
  RouteData get currentRoute => _currentRoute;

  /// its  value will be true after first page is into history
  bool _initialized = false;
  bool get initialized => _initialized;

  /// save all routes keys in one instance of MyRouterDElegate
  void setPaths(List<String> keys) {
    _routerKeys = keys;
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

  ///
  void setState(RouteData routeData) {
    _currentRoute = routeData;
  }

  ///
  void initialize() {
    _initialized = true;
  }
}
