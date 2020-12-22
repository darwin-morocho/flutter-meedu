To navigate between page without a BuildContext you can use the meedu's router module.

In your `MaterialApp`

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

Now since your pages you can navigate without BuildContext

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
  const DetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = router.arguments(context) as String;
    return YOUR_WIDGET;
  }
}
```