## [9.2.0]
- Fixed `autoDispose` not working on `StateNotifier` Providers.
- Upgrade `meedu` to ^9.3.0

## [9.1.1]
- Upgrade `meedu` to ^9.2.2

## [9.1.0]
- Updated to meedu: ^9.1.0

## [9.0.10]
- Prevent dispose provider when didChangeDependencies is called on ConsumerWidget.

## [9.0.9]
- Updated to meedu: ^9.0.3

## [9.0.9]
- Updated to meedu: ^9.0.3

## [9.0.8]
- Fixed persistent state init value.


## [9.0.7]
- Updated to meedu: ^9.0.1

## [9.0.6]
- Updated to meedu: ^9.0.0

## [9.0.5]
- Updated tests.

## [9.0.4]
- Removed `tags` parameter in BaseProvider class in favor to use `BaseTagClass`.

## [9.0.3]
- Added `tags` parameter in BaseProvider class.
- Added assertions to validade the right way to read providers using tags.

## [9.0.2]
- Updated exports;
## [9.0.1]
- Updated readme
## [9.0.0]

# Library Update - Important Information

## Overview

We've introduced some significant changes and improvements in this update. Please take note of the following:

### Breaking Changes

- **Navigator Module**: The `Navigator` module has been removed in favor of using `navigator 2.0` with packages like `go_router`.

- **Auto-Dispose Feature**: The auto-dispose feature is no longer linked to a specific route. Instead, the lifecycle of a `StateNotifier` is now linked to its listeners. When a `StateNotifier` loses all of its listeners, it will be disposed, and the associated provider will also be disposed.

- **SimpleNotifier Class**: The `SimpleNotifier` class has been removed in favor of using immutable states with `StateNotifier` and `Bloc`.

- **StateProvider**: The `StateProvider` has been removed in favor of using `StateNotifierProvider` and `StateNotifierArgumentsProvider`.

- **Get Module**: The `Get` module for dependency injection has been removed in favor of using `Provider` and `FactoryProvider`.

- **ProviderListener** and **MultiProviderListeners**: These have been removed in favor of using the `.listen` function inside a `ConsumerWidget`.

- **ProviderScope**: The `ProviderScope` has been removed in favor of using `ProvidersContainer`.

- Added ref.listen in ConsumerWidget.

### Upgrade Information

Make sure to upgrade to the latest version of our library to benefit from these changes. Refer to our documentation for more details on how to adapt your code to these updates.

For more information and detailed documentation, please visit our [website](https://flutter.meedu.app/).

## [8.5.0]

- Updated to meedu: ^8.1.2

## [8.4.0]

- Updated sdk constraints
  Dart >=3.0.0 <4.0.0
  Flutter >=3.10.0

## [8.3.1]

- Updated to meedu: ^8.0.2

## [8.3.0]

- Updated to meedu: ^8.0.1
- Added Bloc class to be able to use the BLoC pattern.

## [8.2.0]

- Fixed issue [#14](https://github.com/darwin-morocho/flutter-meedu/issues/14).
- Use unmount instead of deactivate for disposed Consumers.

## [8.1.1]

- Updated to meedu: ^7.2.2

## [8.1.0]

- Moved logic from the ConsumerState class to ConsumerStatefulElement class to be
  compatible with `flutter_hooks`.

## [8.0.0]

- **BREAKING CHANGE**
  The `.select` filter has a new behavior. A new optional argument called `booleanCallback` has beed
  added. If your callback (in the `.select` filter) returns a boolean value and you want to
  rebuild your consumers or notify to your listeners only when the boolean
  value is `true` you can set `booleanCallback` to `true`.

  If you don't define the `booleanCallback` argument and your callback returns a boolean (true or false) your consumers and your listeners will be notified when the value returned by the callback changes ( `true` to `false` or `false` to `true`).

  EXAMPLE:

  ```dart
     final controller = ref.watch(
        provider.select(
          (_) => _.user != null,
          booleanCallback: true,
        ),
    );
  ```

## [7.2.0+1]

- Updated to meedu: ^7.2.0+1

## [7.1.0]

- Added `Provider` class to be able to create providers that don't depend of
  SimpleNotifier or StateNotifier.
- Allow `afterFirstLayout` to be overridden with `FutureOr`.
- Allow `dispose` on SimpleNotifier and StateNotifier to be overridden with `FutureOr`.

Example:

```dart
class HomePageUiUtils {
  HomePageUiUtils._();
}
final homeTabController =
```

## [7.0.0]

- **BREAKING CHANGE**

  imports has been renamed.

  Before:

  ```dart
  import 'package:flutter_meedu/router.dart';
  import 'package:flutter_meedu/rx.dart';
  import 'package:flutter_meedu/state.dart';
  import 'package:flutter_meedu/page.dart';
  import 'package:flutter_meedu/navigation.dart';
  import 'package:flutter_meedu/screen_utils.dart';
  ```

  Now:

  ```dart
  import 'package:flutter_meedu/ui.dart'; /// this contains the all previous libraries in one single import
  ```

  > IMPORTANT: `package:flutter_meedu/flutter_meedu.dart` has been removed in favor to `package:flutter_meedu/ui.dart`

- **BREAKING CHANGE**

  Now to use the route module you don't have to use alias.
  Now you have to use the global var `router`

  Before:

  ```dart
  import 'package:flutter_meedu/router.dart' as router;

  MaterialApp(
    navigatorKey: router.navigatorKey,// <-- ADD THIS
    home: HomePage(),
    navigatorObservers: [
      router.observer,// <-- ADD THIS
    ],
    .
    .
    .
  ),
  ```

  Now:

  ```dart
  import 'package:flutter_meedu/ui.dart'; // Alias is not needed any more

  MaterialApp(
    navigatorKey: router.navigatorKey,// <-- ADD THIS
    home: HomePage(),
    navigatorObservers: [
      router.observer,// <-- ADD THIS
    ],
    .
    .
    .
  ),
  ```

- **BREAKING CHANGE**:

  `Get.factoryPut<T,A>` has been replaced for `Get. factoryPut<T>`

  Before:

  ```dart
  Get.factoryPut<AuthRepository, String>(
    (String? arguments) => AuthRepository (arguments!),
  );
    .
    .
    .
  final testRepo = Get.factoryFind<AuthRepository,  String>(
  arguments:"https://test.api.com",
  );
  ```

  Now:

  ```dart
  Get.factoryPut<AuthRepository>(
    (arguments) => AuthRepository(arguments as  String),
  );
    .
    .
    .
  final testRepo = Get.factoryFind<AuthRepository>(
  arguments:"https://test.api.com",
  );
  ```

- Added `AfterFirstLayoutMixin`.
  Add with AfterLayoutMixin<MyWidget> mixin to your State<MyWidget> class and then implement
  the void afterFirstLayout(BuildContext context) abstract method. Code in this method will be
  called the first time this widget is laid out on the screen.

  ```dart
  class MyWidget extends StatefulWidget {
    const _MyWidget({Key? key}) : super(key: key);
    @override
    State<MyWidget> createState() => _MyWidgetState();
  }

  class _MyWidgetState extends State<MyWidget> with AfterFirstLayoutMixin {
    @override
    void afterFirstLayout(BuildContext context) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text('after first layout'),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold();
    }
  }
  ```

- Added `Get.asyncPut<T>`:

  Example:

  ```dart
   Get.asyncPut<Person>(
      (arguments) async {
        await Future.delayed(
          const Duration(milliseconds: 10),
        );
        return Person(arguments as String);
      },
  );
  .
  .
  .
  final person = await Get.asyncFind<Person>  (arguments: 'Darwin');
  ```

## [6.2.5+1]

- Added `export 'src/navigation/transitions/transition.dart';` in navigator library.

## [6.2.5]

- Export `Navigator1` as an independent library.
- Added `ContextNavigatorExt` extension.

## [6.2.4]

- Added class `Navigator1` to easy use push, pushReplacement, pushAndRemoveUntil and all pop methods.

## [6.2.3]

- Updated to meedu: ^5.3.1

## [6.2.2]

- Updated to meedu: ^5.3.0

## [6.2.1]

- Updated to meedu: ^5.2.0

## [6.2.0]

- Updated to meedu: ^5.2.0

## [6.1.0]

- Updated to meedu: ^5.1.0
- Added `PersistentStateMixin` to save the state of your StateNotifers as a JSON.

## [6.0.1]

- Fixed bug due to `addPostFrameCallback` in `ConsumerWidget` when
  an update is called before `addPostFrameCallback` has been completed.

## [6.0.0]

- Release 6.x.x

## [6.0.0-dev.2]

- Removed deprecated methods.

## [6.0.0-dev.1]

- Set min dark sdk >=2.15

## [6.0.0-dev.0]

**BREAKING CHANGE**: removed `.ids` filter in favor to `.select` in `SimpleProvider`.

## [5.3.1]

- Added `@Deprecated` annotation for `.ids` filter, that filter
  will be removed in `flutter_meedu: ^6.x.x`.

- Updated to meedu: ^4.3.0

## [5.3.0+1]

- Updated README.md

## [5.3.0]

- Added support for filters in ProviderListener and MultiProviderListener

For example:

```dart
ProviderListener<CounterController>(
  provider: counterProvider.select(
    (_) => _.counter >= 5,
  ),
  onChange: (_, controller) {

  },
  builder: (_, controller) {
    return YOUR_WIDGET;
  },
);
```

- Added lint rules.

## [5.2.1]

- Added `router.context`.

## [5.2.0+1]

- Updated readme.

## [5.2.0]

- Added validations for bad use of `ref.watch` and `ref.select`.

## [5.1.0]

- now the router module allows you access to the
  route arguments without BuildContext. To do this you need
  to add the observer in your navigatorObservers.

```dart
import 'package:flutter_meedu/router.dart' as router;

MaterialApp(
  navigatorKey: router.navigatorKey,// <-- ADD THIS
  home: HomePage(),
  navigatorObservers: [
    router.observer,// <-- ADD THIS
  ],
  .
  .
  .
),
```

then you can access to the route setting or arguments

```dart
import 'package:flutter_meedu/router.dart' as router;
.
.
.
// now you can use
final arguments = router.arguments;

/// current route settings
final settings = router.settings;

.
.
.
/// also you can pass directly the route arguments to your controllers
final counterProvider = SimpleProvider(
  (_) => CounterController(router.arguments as int),
);

or

final counterProvider = SimpleProvider<CounterController>(
  (_) {
    final initialValue = router.arguments as int;
    return CounterController(initialValue);
  },
);


/// if you need to write unit or widget testing
/// you can use the [overrideProvider] method
setUp((){
  counterProvider.overrideProvider(
    (_) => CounterController(mockedInitialValue),
  );
});
```

## [5.0.1]

- Updated to `meedu: ^4.2.1`

## [5.0.0]

- **BREAKING CHANGE:** Removed `ScopedReader` and replaced by `BuilderRef`.

**Before:**
the watch function allways return the notifier linked to the
provider passed as parameter to the watch function.

```dart
 Consumer(builder: (_, watch, __) {
     final controller = watch(counterProvider);
     return Text("${controller.counter}");
 })
```

```dart
 Consumer(builder: (_, watch, __) {
     final controller = watch(
       counterProvider.select((_) => _.counter),
     );
     return Text("${controller.counter}");
 })
```

**After:**
now the consumer widget has replaced the `watch` parameter for one instance of `BuilderRef`
with this change to listen the changes you need to use `ref.watch`

```dart
 Consumer(builder: (_, ref, __) {
     final controller = ref.watch(counterProvider);
    return Text("${controller.counter}");
 })

// or

 Consumer(builder: (_, ref, __) {
     final controller = ref.watch(
       counterProvider.select((_) => _.counter),
     );
    return Text("${controller.counter}");
 })
```

or if you want direct access to the value returned by ` counterProvider.select((_) => _.counter)` you can use `ref.select`

```dart
 Consumer(builder: (_, ref, __) {
     final int counter = ref.select(
       counterProvider.select((_) => _.counter),
     );
    return Text("$counter");
 })
```

- `ref.watch` can be used to listen the changes in a provider even you can use filters like `.ids, .select` and `.when` with `ref.watch` but it allways returns the notifier linked to the provider.

- `ref.select` can be used to listen the changes in a provider only using filters like `.select` and `.when` and the value returned by `ref.select` depends of the value returned by the filters.

**IMPORTANT:** the `.ids` filter only should be used with `ref.watch`.

##

## [4.4.1]

- Fixed multiples rebuilds with custom transitions using named routes.

## [4.4.0]

- Added `MultiProviderListener` widget.

## [4.3.0]

- Added `autoRemove` and `onRemove` in dependency injection.

## [4.2.1]

- Added **result** parameter in `pushReplacementNamed`.

## [4.2.0]

- Added custom transitions for named routes.
- Updated docs.

## [4.1.1]

- Added isDarkMode extension.

## [4.1.0+3]

- Added const constructor in PageWithArgumentsWidget class.

## [4.1.0+2]

- Added const constructor in PageWithArgumentsWidget class.

## [4.1.0+1]

- Added PageWithArgumentsWidget class.

## [4.1.0]

- Updated to meedu: ^4.1.0

## [4.0.0+2]

- Updated to meedu: ^4.0.0+1
- Improved ConsumerWidget class.

## [4.0.0+1]

- Added comments in the consumer widget.

## [4.0.0-dev.0]

- Removed WatchFilter class.
- Added .ids, .select and .when methods in SimpleProvider and StateProvider.

## [3.0.10]

- Added PageWithArguments Widget.

## [3.0.9]

- Updated to meedu: ^3.0.8

## [3.0.8+1]

- Updated README.

## [3.0.8]

- Updated to meedu: ^3.0.7

## [3.0.7]

- Updated to meedu: ^3.0.6
- Added lint rules.

## [3.0.6]

- Updated to meedu: ^3.0.5

## [3.0.5]

- Updated Navigator Observer.

## [3.0.4]

- Updated to meedu: ^3.0.4

## [3.0.3]

- Updated to meedu: ^3.0.2

## [3.0.2]

- Updated tests

## [3.0.1]

- Updated to meedu: ^3.0.1

## [3.0.0+1]

- Updated README.MD

## [3.0.0]

- Ready for production

## [3.0.0-prev.22]

- Updated to meedu: ^3.0.0-prev.15

## [3.0.0-prev.21]

- Updated to meedu: ^3.0.0-prev.14
- call AutoDispose after route dismiss animation.

## [3.0.0-prev.20]

- Added dispose method in router module.

## [3.0.0-prev.19]

- Updated to meedu: ^3.0.0-prev.13

## [3.0.0-prev.18]

- Updated to meedu: ^3.0.0-prev.11

## [3.0.0-prev.17]

- Removed Logs on Consumer widget.

## [3.0.0-prev.16]

- ProviderListener onChange callback is called after next frame.

## [3.0.0-prev.15]

- Fixed routeName on NavigatorObserver.

## [3.0.0-prev.14]

- Fixed `Provider` widget.

## [3.0.0-prev.13]

- Added WatchFilter class.

## [3.0.0-prev.12]

- Added buildWhen, buildByIds and buildBySelect in the `watch` method of `ConsumerWidget`.

## [3.0.0-prev.11]

- fixed router.arguments.

## [3.0.0-prev.10]

- Fixed autoDispose in pushAndRemoveUntil usinf didRemove.

## [3.0.0-prev.9]

- Fixed autoDispose in pushAndRemoveUntil.

## [3.0.0-prev.8]

- fixed autoDispose for multiples providers.

## [3.0.0-prev.7]

- fixed autoDispose when navigate using `Navigator.push(...)`.

## [3.0.0-prev.6]

- meedu: ^3.0.0-prev.5

## [3.0.0-prev.5]

- meedu: ^3.0.0-prev.4

## [3.0.0-prev.4]

- meedu: ^3.0.0-prev.3

## [3.0.0-prev.3]

- meedu: ^3.0.0-prev.2

## [3.0.0-prev.2]

- Fixed `read` method into `ProviderReference`.

## [3.0.0-prev.1]

- Added events to ProviderListener.

## [3.0.0-prev.0]

- Prev version of 3.0.0

## [2.1.1]

- Fixed router navigator key.

## [2.1.0-prev.1]

- Updated export file.

## [2.1.0-prev.0]

- Updated meedu: ^2.1.0

## [2.0.1]

- Updated meedu: ^2.0.1

## [2.0.0]

- Added support for flutter 2 and null safety.

## [1.1.2]

- Fixed push with Generic types.

## [1.1.1]

- Updated meedu: ^0.5.4.

## [1.1.0]

- Added tag support for Provider.of<...>(...)

## [1.0.5]

- Removed unused imports.

## [1.0.4]

- Fixed route.arguments in ProviderPage.

## [1.0.3+2]

- Updated meedu version.

## [1.0.3+1]

- Added documentation url.

## [1.0.3]

- Added ProviderPage.

## [1.0.2]

- Added SimpleWidget and StateWidget.

## [1.0.1]

- Added screen utils.

## [1.0.0]

- initial version.
