import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:flutter_meedu/flutter_meedu.dart';

import 'path_parser.dart';
import 'route_data.dart';

class RouterState extends ChangeNotifier {
  RouterState._();
  static final RouterState i = RouterState._();

  /// routes all paths (key) from [routes] property of [MyRouterDelegate]
  List<String> _routerKeys = [];
  List<String> get routerKeys => _routerKeys;

  late RouteData _currentRoute;
  RouteData get currentRoute => _currentRoute;

  void setPaths(List<String> keys) {
    _routerKeys = keys;
  }

  void push(
    String path, {
    Map<String, String> queryParameters = const {},
  }) {
    final tmpUri = Uri.parse(path);
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
      final routeData = RouteData(
        key: keyAndParameters?.routeKey,
        uri: uri,
        state: null,
        parameters: keyAndParameters?.parameters ?? {},
      );
      _currentRoute = routeData;
      notifyListeners();
    }
  }

  void setState(RouteData routeData) {
    _currentRoute = routeData;
  }
}
