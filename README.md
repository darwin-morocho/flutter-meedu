# meedu

A simple State Managment, Dependency Injection, Reactive programming and Navigation for Flutter apps.

## Overview

This project was inpired by GetX, we could say that this is a Lite version of GetX but with a little changes in the code and some widgets.

## Features

- A Simple State Managment
- LifeCycle included into controllers
- Navigate without BuildContext
- Simple dependecy injection
- Reactive programming

## State Managment

Juste create a controller

```dart
import 'package:meedu/state.dart';

class HomeController extends MController {
  int counter = 0;

  @override
  void onInit() {
    print("onInit");
  }

  @override
  void afterFirstLayout() {
    print("afterFirstLayout");
  }

  void incremment() {
    counter++;
    update(); // notify and update all MBuilder wigets
  }

  @override
  Future<void> onDispose() {
    // here you can close streams, remove listeners, etc
    return super.onDispose();
  }
}
```

Now you can create you page

```dart
import 'package:flutter/material.dart';
import 'package:meedu/state.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MBuilder<HomeController>(
      controller: HomeController(),
      builder: (controller) => Scaffold(
        body: Center(
            child: MBuilder<HomeController>(
                builder: (controller) => Text(
                    "${controller.counter}",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                ),
            ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.incremment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

The parent `MBuilder` needs to define the `controller` parameter and the childs don't need this parameter only need to know what kind of controller they need to search in the widget tree.

If you have multiples `MBuilder` widgets in your page and you only want update certain `MBuilder` you can use the `id` parameter in yours `MBuilder` and from your controller you can call to `update(['id_one','id_two',...])`.

When you call to `update` and pass it a list of Strings the update method only rerender the `MBuilder` widgets with one id inside the list passed to the `update` method.   


## Navigation
To navigate between page without a BuildContext you can use the meedu's router

In your `MaterialApp`
```dart
import 'package:meedu/router.dart' show MNavigator;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MNavigator.instance.navigatorKey, // add the navigator key
      home: HomePage(),
      routes: {YOUR_ROUTES},
    );
  }
}
```
Now since your pages you can navigate without BuildContext
```dart
import 'package:meedu/router.dart' as router;
.
.
.
router.pushNamed('detail-page', arguments: "your-arguments");
```

If you want get your arguments
```dart
import 'package:flutter/material.dart';
import 'package:meedu/router.dart' as router;


class NumbersPage extends StatelessWidget {
  static const routeName = "/numbers";
  const NumbersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = router.arguments(context) as String;
    return YOUR_WIDGET;
  }
}
```
