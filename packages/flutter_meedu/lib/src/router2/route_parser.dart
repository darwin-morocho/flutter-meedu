import 'package:flutter/widgets.dart' show RouteInformation, RouteInformationParser;
import 'route_data.dart';

class RouteParser extends RouteInformationParser<RouteData> {
  @override
  Future<RouteData> parseRouteInformation(RouteInformation info) async {
    print("parseRouteInformation ${info.location}");
    final uri = Uri.parse(info.location ?? '/');
    return RouteData(
      uri: uri,
      parameters: {},
      state: info.state,
    );
  }

  @override
  RouteInformation? restoreRouteInformation(RouteData configuration) {
    return RouteInformation(
      location: configuration.uri.path,
      state: configuration.state,
    );
  }
}
