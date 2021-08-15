import 'dart:async';

class RouteData<T> {
  /// a string to identifier witch key should be used to create a page
  /// using the [routes] property of a instance of [MyRouterDelegate]
  ///
  /// this value will be null if the not found page should
  /// be showed
  final String? key;

  /// a Uri for the current route
  final Uri uri;

  /// path parameters for the current route
  final Map<String, String> pathParameters;

  /// optional parameters this can be used to
  /// send a custom model or some instance of one class
  /// this property will be null if the user
  /// write directly the URL in browser
  dynamic parameters;

  final Object? state;

  /// The full path that generated this route, including query string.
  String get fullPath => uri.toString();

  /// this value will be used to return data when
  /// a pop event is called and the popped page should
  /// return a data
  final popCompleter = Completer<T?>();

  RouteData({
    required this.key,
    required this.uri,
    required this.pathParameters,
    required this.state,
    required this.parameters,
  });
}
