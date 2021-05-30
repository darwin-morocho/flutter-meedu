---
sidebar_position: 12
---

# Navigation

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
    // for example in the routes parameter of your MaterialApp
    final arguments = router.arguments<String>(context);
    return YOUR_WIDGET;
  }
}
```

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
