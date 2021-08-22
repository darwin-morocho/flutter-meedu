import 'dart:async';

class RouteData<T> {
  String get id => "$hashCode";

  /// a string to identifier witch key should be used to create a page
  /// using the [routes] property of a instance of [MyRouterDelegate]
  ///
  /// this value will be null if the not found page should
  /// be showed
  final String? routeKey;

  /// a Uri for the current route
  final Uri uri;

  /// path parameters for the current route
  final Map<String, String> pathParameters;

  /// optional parameters this can be used to
  /// send a custom model or some instance of one class
  /// this property will be null if the user
  /// write directly the URL in browser
  dynamic parameters;

  final RouteState? state;

  /// The full path that generated this route, including query string.
  String get fullPath => uri.queryParameters.isNotEmpty ? uri.toString() : uri.path;

  /// this value will be used to return data when
  /// a pop event is called and the popped page should
  /// return a data
  final popCompleter = Completer<T?>();

  final RequestSource requestSource;

  RouteData({
    required this.requestSource,
    required this.routeKey,
    required this.uri,
    required this.pathParameters,
    required this.state,
    required this.parameters,
  });

  // Custom implementation of hash code optimized for reading notifiers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}

/// Where the navigation request originated from.
enum RequestSource {
  /// Navigation request came from the system, such as the user typing a URL
  /// into the address bar.
  system,

  /// Navigation request came from an API call, such as `.push()`.
  internal,
}

class RouteState {
  final bool isReplacement;

  RouteState({
    required this.isReplacement,
  });

  static RouteState? fromJSon(Object? state) {
    if (state is Map) {
      return RouteState(
        isReplacement: state['isReplacement'],
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      "isReplacement": isReplacement,
    };
  }
}
