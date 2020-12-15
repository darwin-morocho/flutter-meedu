# meedu

A simple State Managment, Dependency Injection, Reactive programming and Navigation for Flutter apps.

## Overview

This project was inspired by GetX, we could say that this is a Lite version of GetX but with a little changes in the code and some widgets.

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

class HomeController extends MeeduController {
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
    update(); // notify and update all MeeduBuilder wigets
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
    return MeeduProvider<HomeController>(
      controller: HomeController(),
      child: Scaffold(
        body:  MeeduBuilder<HomeController>(
          id: 'counter',
          builder: (controller) => Text(
                    "${controller.counter}\n counter",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: MeeduBuilder<HomeController>(
          allowRebuild: false,
          builder: (_) => FloatingActionButton(
            onPressed: () {
              _.incremment();
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
```

First you need define your `MeeduProvider` and pass it your `controller`.
If you have multiples `MeeduBuilder` widgets in your page and you only want update certain `MeeduBuilder` you can use the `id` parameter in yours `MeeduBuilder` and from your controller you can call to `update(['id_one','id_two',...])`.

When you call to `update` and pass it a list of Strings the update method only rerender the `MeeduBuilder` widgets with one id inside the list passed to the `update` method.

✅ **IMPORTANT** The `MeeduProvider` widget automatically inject your `controller` using `Get.i.put<YourController>()` so you can call to `Get.i.find<YourController>()` from everywhere of your code while your `MeeduProvider` is inside the widget tree. When the `MeeduProvider` is destroyed your `controller` will be removed using `Get.i.remove<YourController>()`.

## Navigation

To navigate between page without a BuildContext you can use the meedu's router

In your `MaterialApp`

```dart
import 'package:meedu/router.dart' as router;

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

class DetailPage extends StatelessWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = router.arguments(context) as String;
    return YOUR_WIDGET;
  }
}
```

## Depency Injection

Just import the library

```dart
import 'package:meedu/get.dart';
```

Now you can inject your dependencies using `MGet.instance` or `MGet.i`

```dart

// inject the dependency as a singleton
Get.i.put<AuthRepository>(new AuthRepositoryImpl());

// get the dependency
Get.i.find<AuthRepository>();

// delete the dependency
Get.i.remove<AuthRepository>();

// use a lazy put to get a new instance every time that you call to MGet.i.lazyFind
Get.i.lazyPut<AuthRepository>(()=>new AuthRepositoryImpl());
Get.i.lazyFind<AuthRepository>();
Get.i.lazyRemove<AuthRepository>();
```

## Reactive programming

Just use the `Rx<T>` class to create one observable

```dart
import 'package:meedu/rx.dart';
Rx<int> counter = Rx(0); // or use Rx<int> counter = 0.obs;
.
.
.
void increment() {
    counter.value++;
}
```

Now you can use the `RxBuilder` widget to listen changes in your observables

```dart
import 'package:meedu/rx.dart';
.
.
.
RxBuilder(
    observables: [
      counter,
    ],
    builder: (ctx) => Text(
        "counter ${_.counter.value}",
    ),
)
```

Check the example for more info abour how to use the `Rx` class with `List` and `Map`.
