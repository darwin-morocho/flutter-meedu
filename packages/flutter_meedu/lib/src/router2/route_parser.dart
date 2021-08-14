import 'package:flutter/widgets.dart' show RouteInformation, RouteInformationParser;
import 'package:flutter_meedu/src/router2/router_state.dart';
import 'route_data.dart';

/// extract the route path without query parameters
String getPathWithoutQuery(String initialPath) {
  final index = initialPath.indexOf("?");
  if (index != -1) {
    return initialPath.substring(0, index);
  }
  return initialPath;
}

class RouteParser extends RouteInformationParser<RouteData> {
  @override
  Future<RouteData> parseRouteInformation(RouteInformation info) async {
    print("parseRouteInformation ${info.location}");

    final location = info.location ?? '/';
    // extract the route path without query parameters
    final path = getPathWithoutQuery(location);

    final tmpUri = Uri.parse(location);

    final uri = Uri(
      path: path,
      queryParameters: {
        ...tmpUri.queryParameters,
      },
    );
    final routeData = RouteData(
      uri: uri,
      parameters: {},
      state: info.state,
    );

    RouterState.i.setState(routeData);

    return routeData;
  }

  @override
  RouteInformation? restoreRouteInformation(RouteData configuration) {
    return RouteInformation(
      location: configuration.uri.path,
      state: configuration.state,
    );
  }
}
