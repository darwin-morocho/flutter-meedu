import 'package:flutter/widgets.dart' show ChangeNotifier;

import 'route_data.dart';

class RouterState extends ChangeNotifier {
  RouterState._();
  static final RouterState i = RouterState._();

  late RouteData _currentRoute;
  RouteData get currentRoute => _currentRoute;

  void push(
    String path, {
    Map<String, String> queryParameters = const {},
  }) {
    if (currentRoute.uri.path != path) {
      final uri = Uri.parse(path);
      final routeData = RouteData(
        uri: uri,
        state: null,
        parameters: {},
      );
      _currentRoute = routeData;
      notifyListeners();
    }
  }

  void setState(RouteData routeData) {
    _currentRoute = routeData;
  }
}
