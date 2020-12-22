First you need import the state module to your files.

```dart
import 'package:meedu/state.dart';
```

## SimpleController

For a simple state managment just create a class that extends of `SimpleController`

```dart
class HomeController extends SimpleController {
  int counter = 0;

  void incremment() {
    counter++;
    update(); // notify and update all SimpleBuilder widgets
  }
}
```

Now in your page or widget you need define a `Provider` and pass to it a new instance of your controller.

```dart
import 'package:flutter/material.dart';
import 'package:meedu/state.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<HomeController>(
      create:(_)=> HomeController(),
      child: Scaffold(
        body:  SimpleBuilder<HomeController>(
          builder: (controller) => Text("${controller.counter}"),
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

The `SimpleBuilder` widget allows you to listen changes in your controller. Use the `allowRebuild` param if you don't want that your `SimpleBuilder` will be render again when the `update` method is called.

If you have multiples `SimpleBuilder` widgets in your page and you only want update certain `SimpleBuilder` you can use the `id` parameter in yours `SimpleBuilder` and from your controller you can call to `update(['id_one','id_two',...])`.

When you call to `update` and pass it a list of Strings the update method only rerender the `SimpleBuilder` widgets with one id inside the list passed to the `update` method.

✅ **IMPORTANT** The `Provider` widget automatically inject your `controller` using `Get.i.put<YourController>()` so you can call to `Get.i.find<YourController>()` from anywhere of your code while your `Provider` is inside the widget tree. When the `Provider` is destroyed your `controller` will be removed using `Get.i.remove<YourController>()`.

For example instead of using a `SimpleBuilder` you can use the `Get` module.
Just import the module

```dart
import 'package:meedu/get.dart';
```

Now you can access to your controller using `Get.i.find`.

```dart
FloatingActionButton(
  onPressed: () {
    final controller = Get.i.find<HomeController>();
    controller.incremment();
   },
  child: Icon(Icons.add),
)
```

## StateController

If you have a more complex State consider using the `StateController` instead of `SimpleController`.

First install [equatable](https://pub.dev/packages/equatable) to compare instances of the same class.
Add `equatable` as a dependency in your pubspec.yaml file

```
equatable: ^1.2.5
```

When you call to `update(newState)` the new state must be different of the current State so `StateBuilder` widget will be rendered again with the new state.

Now you can use the `StateController` class

```dart
class LoginState extends Equatable {
  final String email, password;
  LoginState({
    @required this.email,
    @required this.password,
  });

  static LoginState get initialState => LoginState(email: '', password: '');


  LoginState copyWith({
    String email,
    String password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map toJson() => {"email": this.email, "password": this.password};

  @override
  List<Object> get props => [email, password];
}


class LoginController extends StateController<LoginState> {
  // you need pass an inital state using super
  LoginController():super(LoginState.initialState);

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
}


class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginController>(
      create:(_) => LoginController(),
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

## Life cycle

When a `SimpleController` or a `StateController` is passed to one `Provider` you can track the **Life cycle** of this Provider since your controller.

Just override the respective methods.

```dart
class HomeController extends SimpleController {

  /// called when the controller is inserted into the widget tree by one Provider
  @override
  void onInit() {

  }

  /// called when the provider and its child is rendered for the first time
  @override
  void afterFirstLayout() {

  }

  /// called when the controller is removed because the Provider widget was destroyed
  @override
  Future<void> onDispose() {
    // YOUR CODE HERE
    return super.onDispose();
  }
}
```

❌ **IMPORTANT**: You should never call an `update(...)` method inside the `onInit()` method even if the `update` method does not belong to the current controller.
The `onInit` method is called when the the `Provider` widget is inserted into the **widget tree** but is not rendered yet. So you can use the `afterFirstLayout()` method to notify any change calling `update(...)`.

```dart
class HomeController extends SimpleController {
  @override
  void onInit() {
      update(); //<--  BAD CODE 🤦‍♂️ this produce the next error -->  setState() or markNeedsBuild called during build
      // or
      final SomeController homeController = Get.i.find<SomeController>();
      someController.update(); //<--  BAD CODE 🤦‍♂️
  }


  @override
  void afterFirstLayout() {
    update(); // GOOD CODE 👏
     // or
    final SomeController homeController = Get.i.find<SomeController>();
    someController.update(); //<--  GOOD CODE 👏
  }
}
```

Also the `StateController` class allows you listen when the state is going to change and listen when the state has been changed.

```dart
class LoginController extends StateController<LoginState> {
  LoginController() : super(LoginState.initialState);

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
  bool onStateWillChange(LoginState oldState, LoginState newState) {
    if (oldState.email != newState.email) {
      return newState.email.contains("@");
    }
    return true;
  }

  @override
  void onStateChanged(LoginState oldState, LoginState currentState) {
    print("oldState ${oldState.toJson()}");
    print("currentState ${currentState.toJson()}\n\n");
  }

  @override
  Future<void> onDispose() {
    print(":::: dispose login page");
    return super.onDispose();
  }
}

```
