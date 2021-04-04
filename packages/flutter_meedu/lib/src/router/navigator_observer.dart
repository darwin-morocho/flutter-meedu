import 'package:flutter/widgets.dart';

RouteObserver<PageRoute> get observer => _RouterObserver.i;

class _RouterObserver extends RouteObserver<PageRoute> {
  _RouterObserver._();
  static _RouterObserver i = _RouterObserver._();

  String _getRouteName(PageRoute route) {
    return route.settings.name!;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      print("did pop ${this._getRouteName(route)}");
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      print("did push ${this._getRouteName(route)}");
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute is PageRoute) {
      print("did pop ${this._getRouteName(newRoute)}");
    }
  }
}
