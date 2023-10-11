# Dependency Injection

With the `Get` module you can easy inject your dependencies as a singleton, lazy singleton or as a factory.

## Singletons

```dart
import 'package:flutter_meedu/meedu.dart';

// inject the dependency as a singleton
Get.put<AuthRepository>(AuthRepositoryImpl());

// for lazy singletons use lazyPut
Get.lazyPut<AuthRepository>(
  () => AuthRepositoryImpl(),
);

// whenever part of your code you can get the dependency using
Get.find<AuthRepository>();
// or
final AuthRepository auth = Get.find();

// remove the dependency
Get.remove<AuthRepository>();

```

## Auto remove

First make sure that you have added the meedu observer in your navigator observers [more info](/docs/7.x.x/state-management/intro#how-it-works).

Now when tou call to `Get.put` or `Get.lazyPut` you can use the `autoRemove` parameter and set the value to `true` then when the router who created the dependency
is popped the dependency will be deleted from memory.

## Listen when a singleton was removed

You can use the `onRemove` to define a callback to listen when a dependency has been deleted from memory, so when you call to `Get.remove` or when you called to `Get.put` or `Get.lazyPut` using `autoRemove` equals to `true` the onRemove callback will be called.

```dart
Get.lazyPut<AuthRepository>(
  () => new AuthRepositoryImpl(),
  onRemove: (authRepository) {
      /// YOUR CODE HERE
    authRepository.dispose();
  }
);
```

## Factory

If you want to get a new instance every time you call find in that case you could use `factoryPut`

```dart
class AuthRepository {
  final String apiHost;
  Person([this.apiHost = 'https://dev.api.com']);
}

// register a factory
Get.factoryPut<AuthRepository>((_) => AuthRepository());

// get a new instance of AuthRepository
final repository = Get.factoryFind<AuthRepository>();
```

:::success NOTE

If you want pass an initial value to **AuthRepository**

```dart
Get.factoryPut<AuthRepository, String>(
    (Object? arguments) => AuthRepository(arguments as String),
);

// get a new instance of AuthRepository with a initial value
final testRepo = Get.factoryFind<AuthRepository>(
  arguments:"https://test.api.com",
);
final liveRepo = Get.factoryFind<AuthRepository>(
  arguments:"https://live.api.com",
);
```

:::

## Async Factory

If you want to get a new instance every time you call find but you need to run some asynchronous code in that case you could use `asyncPut`

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

## Testing

To avoid conflics with dependencies injected in the Get module you can clear the dependencies using a `setUp` or a `tearDown` before or after each test.

```dart
setUp((){
 Get.clear(); // remove all dependencies
});
```
