# meedu

A simple State Managment, Dependency Injection, Reactive programming and Navigation for Flutter apps.

## Overview

This project was inspired by GetX, we could say that this is a Lite version of GetX but with best practices in the code, without a custom MaterialApp or custom CuppertinoApp, without Dialogs and Snackbars and any other unnecessary functionality.
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

class HomeController extends SimpleController {
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
    update(); // notify and update all SimpleBuilder widgets
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
    return Provider<HomeController>(
      controller: HomeController(),
      child: Scaffold(
        body:  SimpleBuilder<HomeController>(
          id: 'counter',
          builder: (controller) => Text(
                    "${controller.counter}\n counter",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: SimpleBuilder<HomeController>(
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

First you need define your `Provider` and pass it your `controller`.
If you have multiples `SimpleBuilder` widgets in your page and you only want update certain `SimpleBuilder` you can use the `id` parameter in yours `SimpleBuilder` and from your controller you can call to `update(['id_one','id_two',...])`.

When you call to `update` and pass it a list of Strings the update method only rerender the `SimpleBuilder` widgets with one id inside the list passed to the `update` method.

✅ **IMPORTANT** The `Provider` widget automatically inject your `controller` using `Get.i.put<YourController>()` so you can call to `Get.i.find<YourController>()` from everywhere of your code while your `Provider` is inside the widget tree. When the `Provider` is destroyed your `controller` will be removed using `Get.i.remove<YourController>()`.


### StateController
If you have a more complex State consider using the `StateController` instance of `SimpleController`.

When you call to `update(newState)` the new state must be different of the current State so `StateBuilder` widget will be rendered again with the new state. 

First install [equatable](https://pub.dev/packages/equatable) to compare instances of the same class.

Add `equatable` as a dependency in your pubspec.yaml file
```
equatable: ^1.2.5
```

Now you can use the `StateController` class
```dart
class LoginState extends Equatable {
  final String email, password;
  LoginState({
    @required this.email,
    @required this.password,
  });

  LoginState copyWith({
    String email,
    String password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}


class LoginController extends StateController<LoginState> {
  @override
  LoginState get initialState => LoginState(email: '', password: '');

  void onEmailChanged(String email) {
    update(
      this.state.copyWith(email: email),
    );
  }

  void onPasswordChanged(String password) {
    update(
      this.state.copyWith(password: password),
    );
  }

  @override
  Future<void> onDispose() {
    print(":::: dispose login page");
    return super.onDispose();
  }
}


class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginController>(
      controller: LoginController(),
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Builder(
            builder: (_) {
              final controller = Provider.of<LoginController>(_);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoTextField(
                    onChanged: controller.onEmailChanged,
                    placeholder: "email",
                  ),
                  SizedBox(height: 20),
                  CupertinoTextField(
                    onChanged: controller.onPasswordChanged,
                    placeholder: "password",
                  ),
                  SizedBox(height: 20),
                  StateBuilder<LoginController, LoginState>(
                    builder: (_) => Text("email is ${_.state.email}"),
                  ),
                  StateBuilder<LoginController, LoginState>(
                    buildWhen: (oldState, newState) => oldState.password != newState.password,
                    builder: (_) => Text("password is ${_.state.password}"),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}




```

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
        "counter ${counter.value}",
    ),
)
```

Check the example for more info abour how to use the `Rx` class with `List` and `Map`.
