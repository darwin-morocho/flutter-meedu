class RouteData {
  /// a string to identifier witch key should be used to create a page
  /// using the [routes] property of a instance of [MyRouterDelegate]
  ///
  /// this value will be null if the not found page should
  /// be showed
  final String? key;

  /// a Uri for the current route
  final Uri uri;

  /// path parameters for the current route
  final Map<String, String> parameters;

  final Object? state;

  /// The full path that generated this route, including query string.
  String get fullPath => uri.toString();

  RouteData({
    required this.key,
    required this.uri,
    required this.parameters,
    required this.state,
  });
}
