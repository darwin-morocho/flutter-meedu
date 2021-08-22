import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show RouteInformation, RouteInformationParser;

import 'path_parser.dart';
import 'router_delegate.dart';
import 'router_state.dart';
import 'route_data.dart';

class RouteParser extends RouteInformationParser<RouteData> {
  const RouteParser();

  @override
  SynchronousFuture<RouteData> parseRouteInformation(RouteInformation info) {
    final location = info.location ?? '/';
    // extract the route path without query parameters
    String path = getPathWithoutQuery(location);
    final initialRoute = MyRouterDelegate.initialRoute;

    final initialized = RouterState.i.initialRouteData != null;

    /// check if the user defined an initial toute
    if (!initialized && path == '/' && initialRoute != path) {
      path = initialRoute;
    }

    /// create a tmp uri to get the query parameters in
    /// info.location
    final tmpUri = Uri.parse(location);

    /// the uri that will be used
    /// for the current route
    final uri = Uri(
      path: path,
      queryParameters: {
        ...tmpUri.queryParameters,
      },
    );

    /// get the route key and the path parameters
    final keyAndParameters = getRouteKeyAndParameters(uri);

    final routeData = RouteData(
      routeKey: keyAndParameters?.routeKey,
      uri: uri,
      pathParameters: keyAndParameters?.parameters ?? {},
      state: RouteState.fromJSon(
        info.state,
      ),
      parameters: null,
      requestSource: RequestSource.system,
    );

    if (!initialized) {
      RouterState.i.setInitialRouteData(routeData);
    }

    return SynchronousFuture(routeData);
  }

  @override
  RouteInformation? restoreRouteInformation(RouteData configuration) {
    if (RouterState.i.isReplacement) {
      RouterState.i.isReplacement = false;
      return null;
    }
    String location = configuration.fullPath;
    print("🔥");

    return RouteInformation(
      location: location,
      state: configuration.state?.toJson(),
    );
  }
}

/// extract the route path without query parameters
String getPathWithoutQuery(String initialPath) {
  return Uri.parse(initialPath).path;
}
