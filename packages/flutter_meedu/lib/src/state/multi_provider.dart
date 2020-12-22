import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart' as p;
import 'provider.dart';

/// [MultiProvider] converts the [Provider] list into a tree of nested
/// [Provider] widgets.
/// As a result, the only advantage of using [MultiProvider] is improved
/// readability due to the reduction in nesting and boilerplate.
class MultiProvider extends p.MultiProvider {
  MultiProvider({
    Key key,
    @required Widget child,
    @required List<Provider> providers,
  })  : assert(child != null && providers != null),
        super(
          key: key,
          child: child,
          providers: providers,
        );
}
