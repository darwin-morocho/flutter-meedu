// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/widgets.dart';

import '../../meedu.dart';
import 'router/navigator.dart';

/// the observer to listen the changes in the stack route
NavigatorObserver get observer => _NavigatorObserver();

/// this class is used to listen the changed in the stack route
class _NavigatorObserver extends NavigatorObserver {
  /// return a name for a route
  String _getRouteName(PageRoute route) {
    return '${route.hashCode}';
  }

  /// check if the popped routes has notifier attached to it and dispose
  /// the notifiers and delete its from the ProviderScope
  Future<void> _checkAutoDispose(Route? route) async {
    if (route is PageRoute) {
      final routeName = _getRouteName(route);

      /// if we have notifiers into the ProviderScope
      if (ProviderScope.initialized &&
          ProviderScope.instance.containers.isNotEmpty) {
        /// get all notifiers attached to the current route
        final containers = ProviderScope.instance.containers.values.where(
          (e) => e.routeName == routeName,
        );

        final keysToRemove = <int>[]; // save the notifier's keys to be disposed

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
            ProviderScope.instance.containers.removeWhere(
              (key, value) => keysToRemove.contains(key),
            );
          }
        }
      }

      /// get all dependencies injected using put or lazyPut
      Get.dependencies.removeWhere((key, value) {
        final remove = value.creatorName == routeName && value.autoRemove;
        final dependency = value.dependency;
        final dynamicValue = value as dynamic;
        if (remove && dynamicValue.onRemove != null) {
          dynamicValue.onRemove(dependency);
        }
        return remove;
      });
    }
  }

  /// set the current route name
  void _setCurrentRoute(
    Route? route, {
    bool checkAutoDispose = false,
  }) {
    if (route is PageRoute && route.isCurrent) {
      BaseProvider.creatorName = _getRouteName(route);
      MeeduNavigator.i.setRouteSettings(route.settings);
      if (checkAutoDispose) {
        // wait to the popped animation transisiton
        route.completed.then((_) => _checkAutoDispose(route));
      }
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _setCurrentRoute(previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _setCurrentRoute(previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _setCurrentRoute(
      route,
      checkAutoDispose: true,
    );
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _setCurrentRoute(
      newRoute,
      checkAutoDispose: true,
    );
  }
}
