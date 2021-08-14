class RouteData {
  final Uri uri;
  final Map<String, String> parameters;
  final Object? state;

  RouteData({
    required this.uri,
    required this.parameters,
    required this.state,
  });
}
