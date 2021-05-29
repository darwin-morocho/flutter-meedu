import 'package:flutter/widgets.dart';
import 'package:meedu/provider.dart';

/// the observer to listen the changes in the stack route
RouteObserver<PageRoute> get observer => _RouterObserver.i;

/// this class is used to listen the changed in the stack route
class _RouterObserver extends RouteObserver<PageRoute> {
  _RouterObserver._();
  static _RouterObserver i = _RouterObserver._();

  /// return a name for a route
  String _getRouteName(PageRoute route) {
    return route.settings.name ?? "${route.hashCode}";
  }

  /// check if the popped routes has notifier attached to it and dispose
  /// the notifiers and delete its from the ProviderScope
  void _checkAutoDispose(Route? route) async {
    if (route is PageRoute) {
      await route.completed; // wait to the animation transisiton
      final routeName = this._getRouteName(route);

      /// if we have notifiers into the ProviderScope
      if (ProviderScope.containers.isNotEmpty) {
        /// get all notifiers attached to the current route
        final containers = ProviderScope.containers.values.where(
          (e) => e.routeName == routeName,
        );
        List<int> keysToRemove = []; // save the notifier's keys to be disposed

        // if the popped route has notifiers
        if (containers.isNotEmpty) {
          for (final container in containers) {
            // if the auto dispose is enabled
            if (container.autoDispose) {
              // save the key to be used later
              keysToRemove.add(container.providerHashCode);
              container.reference.dispose(); // dispose the current notifier
            }
          }

          // remove the notifiers for the ProviderScope
          if (keysToRemove.isNotEmpty) {
            ProviderScope.containers.removeWhere(
              (key, value) => keysToRemove.contains(key),
            );
          }
        }
      }
    }
  }

  /// set the current route name
  void _setCurrentRoute(Route? route) {
    if (route is PageRoute) {
      BaseProvider.creatorName = this._getRouteName(route);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _checkAutoDispose(route);
    _setCurrentRoute(previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _checkAutoDispose(route);
    _setCurrentRoute(previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _setCurrentRoute(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _setCurrentRoute(newRoute);
    _checkAutoDispose(oldRoute);
  }
}
