# Navigation
:::note
**flutter_meedu** uses **navigator 1.0** in its router module and there is not planned add **navigator 2.0** as a new router module because there is not an easy way to create a router package with navigator 2.0 that fits all posible navigation flows that a developer might want to create.

In that case you can use any other package on [pub.dev](https://pub.dev) to manage your navigation with navigation 2.0 and use flutter_meedu to manage your state without any problem just be sure to add the flutter_meedu observer in your `navigatorObservers`.
:::

To navigate between page without a BuildContext you can use the meedu's router module.

In your MaterialApp

```dart
import 'package:flutter_meedu/router.dart' as router;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: router.navigatorKey, // add the navigator key
      home: HomePage(),
      routes: {YOUR_ROUTES},
    );
  }
}
```

Now you can navigate without BuildContext

```dart
import 'package:flutter_meedu/router.dart' as router;
.
.
.
router.pushNamed('detail-page', arguments: "your-arguments");
```

If you want get your arguments

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WARNING: when you use ModalRoute.of(context).settings.arguments
    // inside a build method this could rebuild your widget when it is destroyed.
    // router.arguments<String>(context) uses  ModalRoute.of(context).settings.arguments
    // in that cases I recommend get your arguments before create your Page
    // in that case you can use the PageWithArgumentsWidget class
    final arguments = router.arguments<String>(context);
    return YOUR_WIDGET;
  }
}
```

## onGenerateRoute
If you want to use the `onGenerateRoute` parameter of your MaterialApp or CupertinoApp you must define the `key` parameter.
```dart {7}
import 'package:flutter_meedu/router.dart' as router;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: router.appKey,// add the route key
      navigatorKey: router.navigatorKey, // add the navigator key
      onGenerateRoute: (settings) {
        final name = settings.name;
        switch (name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => HomePage(),
            );

          case '/counter':
            return MaterialPageRoute(
              builder: (_) => CounterPage(),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Text("Page not found"),
                ),
              ),
            );
        }
      },
    );
  }
}
```


## Named routes with custom transitions
If you want to override the default transition when use named routes
you need to define the `key` parameter of your MaterialApp or CupertinoApp
```dart {5,13}
import 'package:flutter_meedu/router.dart' as router;

void main() {
  // overrride the default page transition for named and non named routes
  router.setDefaultTransition(router.Transition.downToUp);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: router.appKey,// add the route key
      navigatorKey: router.navigatorKey, // add the navigator key
      home: HomePage(),
      routes: {YOUR_ROUTES},
    );
  }
}
```
:::info
Posible transitions
```dart
enum Transition {
  fadeIn,
  rightToLeft,
  upToDown,
  downToUp,
  zoom,
  none,
  cupertino,
  material,
}
```
:::




## Testing

For widget testing you will need to dispose the NavigatorState created by `router.navigatorKey` before or after each test

```dart
import 'package:flutter_meedu/router.dart' as router;

.
.
.

setUp((){
  router.dispose();
});

// or

tearDown((){
  router.dispose();
});
```
