import 'router_state.dart';

/// this function recives a uri and compare its path
/// with all routes keys in RouterState
///
/// returns  null if the route key was not found
KeyWithParameters? getRouteKeyAndParameters(Uri uri) {
  // get all keys from all routes in an instance of MyRouterDelegate
  final keys = RouterState.i.routerKeys;
  final path = uri.path.trim();
  // if the uri path is equals to one key
  // user uri.path as key
  if (keys.contains(path)) {
    return KeyWithParameters(path, {});
  }

  /// a map to save the route's parameters
  Map<String, String> parameters = {};

  /// will store the routeKey for the current uri.path
  String? routeKey;

  for (final key in keys) {
    final splitKey = key.split("/");
    if (key.startsWith('/')) {
      splitKey.removeAt(0); // remove the first '/'
    }

    final segments = uri.pathSegments;
    print("👀👀 key: $splitKey, path: ${segments}");
    // check if the current key has the same segmets
    // of uri.path
    if (splitKey.length == segments.length) {
      /// create a string identifier for routeKey and uri.path
      String keyIdentifier = '', pathIdentifer = '';

      for (int i = 0; i < segments.length; i++) {
        final itemKey = splitKey[i];
        final segment = segments[i];

        if (itemKey.startsWith(':')) {
          // if the current key segment sould be
          // a parameter
          parameters[itemKey.substring(1)] = segment;
        } else {
          keyIdentifier += itemKey;
          pathIdentifer += segment;
        }
      }

      print("keyIdentifier:: $keyIdentifier");
      print("pathIdentifer:: $pathIdentifer");

      /// if keyIdentifier and pathIdentifer are equals
      /// we found the routeKey for the current uri.path
      if (keyIdentifier == pathIdentifer) {
        routeKey = key;
        break;
      } else {
        // reset the parameters for the next key iteration
        parameters = {};
      }
    }
  }
  if (routeKey != null) {
    return KeyWithParameters(
      routeKey,
      parameters,
    );
  }
}

class KeyWithParameters {
  /// the route key to identifier in a routes map
  /// witch key should be used to create a page
  final String routeKey;

  /// route's parameters
  final Map<String, String> parameters;

  KeyWithParameters(
    this.routeKey,
    this.parameters,
  );
}
