## [6.2.5]
- Export `Navigator1` as an independent library.
- Added `StateNavigatorMixin` mixin and `ContextNavigatorExt` extension.
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
