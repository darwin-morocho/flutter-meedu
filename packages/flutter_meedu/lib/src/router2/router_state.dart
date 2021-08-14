import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:flutter_meedu/flutter_meedu.dart';

import 'route_data.dart';

class RouterState extends ChangeNotifier {
  RouterState._();
  static final RouterState i = RouterState._();

  String _intialPath = '';
  String get intialPath => _intialPath;

  late RouteData _currentRoute;
  RouteData get currentRoute => _currentRoute;

  void setInitialPath(String location) {
    if (_intialPath.isEmpty) {
      _intialPath = location;
    }
  }

  void push(
    String path, {
    Map<String, String> queryParameters = const {},
  }) {
    if (currentRoute.uri.path != path) {
      final tmpUri = Uri.parse(path);

      final routeData = RouteData(
        uri: Uri(
          path: getPathWithoutQuery(path),
          queryParameters: {
            ...tmpUri.queryParameters,
            ...queryParameters,
          },
        ),
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
