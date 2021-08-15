import 'package:flutter/widgets.dart' show RouteInformation, RouteInformationParser;

import 'path_parser.dart';
import 'router_delegate.dart';
import 'router_state.dart';
import 'route_data.dart';

class RouteParser extends RouteInformationParser<RouteData> {
  const RouteParser();

  @override
  Future<RouteData> parseRouteInformation(RouteInformation info) async {
    final location = info.location ?? '/';
    // extract the route path without query parameters
    String path = getPathWithoutQuery(location);
    final initialRoute = MyRouterDelegate.initialRoute;

    /// check if the user defined an initial toute
    if (!RouterState.i.initialized && initialRoute != path) {
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
      key: keyAndParameters?.routeKey,
      uri: uri,
      pathParameters: keyAndParameters?.parameters ?? {},
      state: info.state,
      parameters: null,
    );

    RouterState.i.setState(routeData);

    return routeData;
  }

  @override
  RouteInformation? restoreRouteInformation(RouteData configuration) {
    String location = configuration.fullPath;
    // removes '?' if the given location doesn't have a query
    final withoutQueryParameters = configuration.uri.queryParameters.isEmpty;
    if (withoutQueryParameters && location.contains("?")) {
      location = location.replaceFirst("?", "");
    }
    return RouteInformation(
      location: location,
      state: configuration.state,
    );
  }
}

/// extract the route path without query parameters
String getPathWithoutQuery(String initialPath) {
  return Uri.parse(initialPath).path;
}
