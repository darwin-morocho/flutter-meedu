## [8.0.1]
- Added tests.
## [8.0.0]
- Added Bloc class to be able to use the BLoC pattern.

## [7.2.2]
- Removed Assertion Error when a notify event
is called after that a notifier was disposed;

## [7.2.1]
- Added `contains` method in `BaseTagProvider` to check 
if a tagged provider is registered.

Example:
```dart
final movieProvider = StateProvider.withTag(
  (ref) => BlocOrController(),
);
.
.
.
if (movieProvider.contains('movie-tag')){
  
}
```



## [7.2.0+1]
- Updated `meta` to `1.8.0`
- Updated `test` to `1.21.6`
- Updated `equatable` to `2.0.5`
## [7.2.0]
- Updated `meta` to `1.7.0`
## [7.1.2]
- Improved code quality for Rx extensions.
- Updated `meta` to `1.8.0`
- Updated `test` to `1.21.4`

## [7.1.1]
- Allow `dispose` on BaseNotifier to be overridden with `FutureOr`.

## [7.0.0]
- Added Provider class to be able to create providers that don't depend of
SimpleNotifier or StateNotifier.

## [6.0.0]
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
final person = await Get.asyncFind<Person>(arguments: 'Darwin');
```

- **BREAKING CHANGE**:

`Get.factoryPut<T,A>` has been replaced for `Get.factoryPut<T>`

Before:

```dart
Get.factoryPut<AuthRepository, String>(
  (String? arguments) => AuthRepository(arguments!),
);
  .
  .
  .
final testRepo = Get.factoryFind<AuthRepository, String>(
arguments:"https://test.api.com",
);
```

Now:

```dart
Get.factoryPut<AuthRepository>(
  (arguments) => AuthRepository(arguments as String),
);
  .
  .
  .
final testRepo = Get.factoryFind<AuthRepository>(
arguments:"https://test.api.com",
);
```

## [5.3.1]

- Removed custom type Json.

## [5.3.0]

- Updated exports.

## [5.2.0]

- Updated `PersistentStateMixin` to be compatible with unions.

## [5.1.0]

- Added `PersistentStateMixin` to save the state of your StateNotifers as a JSON.

## [5.0.0]

- **BREAKING CHANGE**: Removed `ids` parameter from notify method in SimpleNotifier.
- **BREAKING CHANGE**: class `RxWorker` has been renamed to `RxReaction`.
  > "Worker" for most programmers (especially with Java or Android experience) is associated with "worker thread" (doing tasks in a background)
- **BREAKING CHANGE**: For dependency injection `Get.i` is not used any more, now you
  must use `Get`.
  For example `Get.put<type>(...)`, `Get.lazyPut<type>(()=>...)`, etc.

- Set min dark sdk >=2.15

## [4.3.0]

- Added `@Deprecated` annotation for ids in the notify method fo a SimpleNotifier.

## [4.2.1+1]

- Updated readme.

## [4.2.1]

- Fixed `onRemove` callback with lazyPut.

## [4.2.0]

- Added autoRemove and onRemove in dependency injection.

## [4.1.0]

- Renamed `onDispose` to `dispose`.
- Added `onlyUpdate` method in StateNotifier.

## [4.0.0+1]

- Added custom hash code in BaseNotifier.

## [4.0.0-dev.0]

- Added base class Provider.

## [3.0.8]

- Updated setArguments

## [3.0.7]

- ProviderScope as a singleton.

## [3.0.6]

- Added lint rules.

## [3.0.5]

- Added overrideTagProvider.

## [3.0.4]

- Added \_oldState again from StateNotifier.

## [3.0.3]

- Revomed \_oldState from StateNotifier.

## [3.0.2]

- Added \_overriddenAutoDispose in overrideProvider method.

## [3.0.1]

- Added arguments in Get.i.factoryPut.

## [3.0.0]

- Ready for production

## [3.0.0-prev.15]

- changed arguments type to dynamic in setArguments method.

## [3.0.0-prev.14]

- change return type in setArguments method.

## [3.0.0-prev.13]

- Added clear method in Get class.

## [3.0.0-prev.12]

- Added clear method in ProviderScope class.

### [3.0.0-prev.11]

- Added overrideProvider method.

## [3.0.0-prev.10]

- Allow null arguments in setArguments method.

## [3.0.0-prev.9]

- updated tests and added ProviderScope class.

## [3.0.0-prev.8]

- Added buildWhen, buildByIds and buildBySelect in the `watch` method of `ConsumerWidget`.

## [3.0.0-prev.7]

- improved code.

## [3.0.0-prev.6]

- Fixed auto dispose.

## [3.0.0-prev.5]

- fixed read a notifier after dispose.

## [3.0.0-prev.4]

- Fixed arguments in ProviderReference

## [3.0.0-prev.3]

- fixed factoryPut.

## [3.0.0-prev.2]

- Added `Get.i.factoryPut`.

## [3.0.0-prev.1]

- Fixed `read` method into `ProviderReference`.

## [3.0.0-prev.0]

- Prev version of 3.0.0

## [2.1.0]

- Updated Get.i.find with lazy param.

## [2.0.1]

- Removed T? in RxWorker.

## [2.0.0]

- Added support for flutter 2 and null safety.

## [0.6.0-nullsafety.1]

- Fixed Get.i.find<...>()

## [0.6.0-nullsafety.0]

- Added support for null safety.

## [0.5.4]

- Fixed \_debugAssertNotDisposed(); on removeListener.

## [0.5.3]

- Removed unused imports.

## [0.5.2+2]

- Removed Future<void> from onDispose().

## [0.5.2+1]

- Added documentation url.

## [0.5.2]

- Improved BaseController.

## [0.5.1]

- Added Rx workers.

## [0.5.0]

- Create 2 packages meedu and flutter_meedu.

## [0.4.2+1]

- Fixed provider afterFirstlayout.

## [0.4.2]

- Added MultiProvider.

## [0.4.1+2]

- Animate transition to named route.

## [0.4.1+1]

- Updated code documentation.

## [0.4.1]

- Removed streams from BaseController.
- Updated documentation.

## [0.4.0+1]

- Updated documentation.

## [0.4.0]

- Updated documentation.
- Updated Tests.
- Added onStateWillChange and onStateChanged on StateController.
- Added initialState on StateController's constructor.

## [0.3.1]

- Fixed popUntil and pushNamedAndRemoveUntil.
- Added Tests.

## [0.3.0]

- Renamed MeeduProvider to Provider.
- Renamed MeeduBuilder to SimpleBuilder.
- Added SimpleController and StateController.
- Added StateBuilder.

## [0.2.2]

- Added page transitions.
- MeeduProvider inject the MeeduController using Get.i.put.

## [0.2.1+1]

- Updated Callbacks.

## [0.2.1]

- Removed State param from MeeduBuilder callbacks.

## [0.2.0+1]

- Removed logs.

## [0.2.0]

- Updated RxBuilder

## [0.1.1]

- Renamed MGet to Get
- Renamed MController to MeeduController
- Renamed MBuilder to MeeduBuilder
- Updated documentation

## [0.1.0]

- Initial version
