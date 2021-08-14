import 'package:flutter/widgets.dart';

import 'page_container.dart';
import 'route_data.dart';
import 'router_state.dart';
import '../../router.dart' as router;

class MyRouterDelegate extends RouterDelegate<RouteData>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteData> {
  final Map<String, Page<dynamic> Function(RouteData)> routes;

  List<PageContainer> _containers = [];

  RouterState get state => RouterState.i;
  RouteData get currentRoute => state.currentRoute;

  bool _initialized = false;

  final List<NavigatorObserver> observers;

  MyRouterDelegate({
    required this.routes,
    this.observers = const [],
  }) {
    state.addListener(() {
      setNewRoutePath(currentRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: pages,
      observers: [
        router.observer,
        ...observers,
      ],
      onPopPage: (route, result) {
        final popped = route.didPop(result);
        if (popped) {
          final copy = [..._containers];

          final index = copy.indexWhere(
            (e) => e.data.uri.path == currentRoute.uri.path,
          );
          print("index $index");
          if (index != -1) {
            copy.removeAt(index);
            _containers = copy;
            state.setState(_containers.last.data);
            notifyListeners();
            print("removed");
          }
        }
        return popped;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteData routeData) async {
    if (_initialized) {
      print("setNewRoutePath ${routeData.uri.path}");
      _insertPageFromData(routeData);
      notifyListeners();
    }
    _initialized = true;
  }

  List<Page> get pages {
    if (_containers.isEmpty) {
      print("🔥");
      if (!routes.containsKey('/')) {
        throw AssertionError("/ default page not defined");
      }
      final routeData = _insertPageFromPath('/');
      state.setState(routeData);
    }
    print("🥶 ${_containers.length}");
    return _containers.map((e) => e.page).toList();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => router.navigatorKey;

  @override
  RouteData? get currentConfiguration => currentRoute;

  RouteData _insertPageFromPath(String path) {
    final uri = Uri.parse(path);
    final routeData = RouteData(
      uri: uri,
      state: null,
      parameters: {},
    );
    _containers = [
      ..._containers,
      PageContainer(
        routes[path]!(routeData),
        routeData,
      ),
    ];
    return routeData;
  }

  void _insertPageFromData(RouteData routeData) {
    _containers = [
      ..._containers,
      PageContainer(
        routes[routeData.uri.path]!(routeData),
        routeData,
      ),
    ];
  }
}
