import 'package:flutter/widgets.dart';
import 'package:meedu/provider.dart';

RouteObserver<PageRoute> get observer => _RouterObserver.i;

class _RouterObserver extends RouteObserver<PageRoute> {
  _RouterObserver._();
  static _RouterObserver i = _RouterObserver._();

  String _getRouteName(PageRoute route) {
    return route.settings.name ?? "${route.hashCode}";
  }

  void _checkAutoDispose(Route? route) async {
    if (route is PageRoute) {
      final routeName = this._getRouteName(route);
      if (ProviderScope.containers.isNotEmpty) {
        final containers = ProviderScope.containers.values.where(
          (e) => e.routeName == routeName,
        );
        List<int> keysToRemove = [];
        if (containers.isNotEmpty) {
          for (final container in containers) {
            if (container.autoDispose) {
              keysToRemove.add(container.providerHashCode);
              container.reference.dispose();
            }
          }

          if (keysToRemove.isNotEmpty) {
            ProviderScope.containers.removeWhere(
              (key, value) => keysToRemove.contains(key),
            );
          }
        }
      }
    }
  }

  void _setCurrentRoute(Route? route) {
    if (route is PageRoute) {
      BaseProvider.flutterCurrentRoute = this._getRouteName(route);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _checkAutoDispose(route);
    _setCurrentRoute(previousRoute);
    super.didRemove(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _checkAutoDispose(route);
    _setCurrentRoute(previousRoute);
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _setCurrentRoute(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _setCurrentRoute(newRoute);
    _checkAutoDispose(oldRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
